REGISTER /usr/lib/pig/contrib/piggybank/java/piggybank.jar;

--
-- Combine the followers field (fo_i) from the multigraph degree distribution
-- with the multigraph pagerank dataset
--

%default OUT '/tmp/graph/pagerank_with_fo'

degrees = LOAD '$DIST'    AS (user_id:int, fo_o:int, fo_i:int, at_o:int, at_i:int, re_o:int, re_i:int, rt_o:int, rt_i:int);
rank    = LOAD '$PRGRAPH' AS (user_id:long, raw_fo_rank:float, raw_at_rank:float, list:chararray); -- load everything

rank_c   = FOREACH rank GENERATE user_id, raw_fo_rank, raw_at_rank;
mapping  = FOREACH degrees GENERATE user_id AS user_id, fo_i AS followers_count; -- get list of followers observed
joined   = JOIN rank BY user_id, mapping BY user_id; 
rank_fol = FOREACH joined GENERATE
             rank::user_id            AS user_id,
             mapping::followers_count AS followers_count,
             rank::raw_fo_rank        AS raw_fo_rank,
             rank::raw_at_rank        AS raw_at_rank
           ;

rank_g   = GROUP rank_fol ALL;
rank_m   = FOREACH rank_g GENERATE FLATTEN(rank_fol), MAX(rank_fol.raw_fo_rank) AS max_fo_rank, MAX(rank_fol.raw_at_rank) AS max_at_rank;
rank_out = FOREACH rank_m {
             -- scale rank to range from [0..10]
             scaled_fo = 10.0f*( (float)org.apache.pig.piggybank.evaluation.math.LOG(rank_fol::raw_fo_rank + 1.0f) / (float)org.apache.pig.piggybank.evaluation.math.LOG(max_fo_rank + 1.0f) );
             scaled_at = 10.0f*( (float)org.apache.pig.piggybank.evaluation.math.LOG(rank_fol::raw_at_rank + 1.0f) / (float)org.apache.pig.piggybank.evaluation.math.LOG(max_at_rank + 1.0f) );
             GENERATE
               rank_fol::user_id         AS user_id,
               scaled_fo                 AS fo_rank,
               scaled_at                 AS at_rank,                     
               rank_fol::followers_count AS followers_count
             ;
           };

STORE rank_out INTO '$OUT';
