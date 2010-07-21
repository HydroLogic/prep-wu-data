%default TABLE  '/data/sn/tw/fixd/objects/twitter_user_id'
%default ATS    '/data/sn/tw/fixd/objects/a_atsigns_b_name'
%default RTS    '/data/sn/tw/fixd/objects/a_retweets_b_name'
%default AATSB  '/data/sn/tw/fixd/objects/a_atsigns_b'
%default ARTB   '/data/sn/tw/fixd/objects/a_retweets_b'
        
id_table = LOAD '$TABLE'  AS (rsrc:chararray, uid:long, scrat:long, sn:chararray, prot:int, followers:int, friends:int, statuses:int, favs:int, crat:long, sid:long, isfull:int, health:chararray);
atsigns  = LOAD '$ATS'    AS (rsrc:chararray, user_a_id:long, user_b_name:chararray, twid:long, crat:long);
retweets = LOAD '$RTS'    AS (rsrc:chararray, user_a_id:long, user_b_name:chararray, twid:long, crat:long, plz_flag:int);

-- rectify atsigns
mapping      = FOREACH id_table GENERATE uid, sn;
ats_joined   = JOIN atsigns BY user_b_name, mapping BY sn;
ats_filtered = FILTER ats_joined BY mapping::uid IS NOT NULL; -- naughty naughty
a_atsigns_b  = FOREACH ats_filtered GENERATE
                    'a_atsigns_b'       AS rsrc,
                    atsigns::user_a_id  AS user_a_id,
                    mapping::uid        AS user_b_id,
                    atsigns::twid       AS twid,
                    atsigns::crat       AS crat
               ;
rmf $AATSB;
STORE a_atsigns_b INTO '$AATSB';

-- rectify retweets
rts_joined   = JOIN retweets BY user_b_name, mapping BY sn;
rts_filtered = FILTER rts_joined BY mapping::uid IS NOT NULL; -- naughty naughty
a_retweets_b = FOREACH rts_filtered GENERATE
                  'a_retweets_b'      AS rsrc,
                  retweets::user_a_id AS user_a_id,
                  mapping::uid        AS user_b_id,
                  retweets::twid      AS twid,
                  retweets::crat      AS crat,
                  retweets::plz_flag  AS plz_flag
              ;
rmf $ARTB;
STORE a_retweets_b INTO '$ARTB';
