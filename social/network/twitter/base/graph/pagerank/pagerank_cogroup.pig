%default CURR_ITER_FILE 'pagerank_graph_000'
%default NEXT_ITER_FILE 'pagerank_graph_001'
%default DAMP   '0.85f' -- naively accepting that given in the wikipedia article on pagerank...

network      = LOAD '$CURR_ITER_FILE' AS (user_a:int, rank:float, out_links:bag { link:tuple (user_b:int) });

-- Generate payments for each user, and their orginal link
sent_shares  = FOREACH network GENERATE FLATTEN(out_links) AS user_b, (float)(rank / (float)SIZE(out_links)) AS share:float;
sent_links   = FOREACH network GENERATE user_a, out_links;

-- Aggregate each user's incoming payments along with their neighborhood
rcvd_shares  = COGROUP sent_links BY user_a INNER, sent_shares BY user_b;

-- Accumulate the payments into next trstrank value
next_iter    = FOREACH rcvd_shares
  {
  raw_rank    = (float)SUM(sent_shares.share);
  -- treat the case that a node has no in links                   
  damped_rank = ((raw_rank IS NOT NULL AND raw_rank > 1.0e-12f) ? raw_rank*0.85f + 0.15f : 0.0f);
  GENERATE
    group         AS user_a,
    damped_rank   AS rank,
    FLATTEN(sent_links.out_links) -- hack, should only be one bag, unbag it
    ;
};

-- Store result
rmf                   $NEXT_ITER_FILE 
STORE next_iter INTO '$NEXT_ITER_FILE';
