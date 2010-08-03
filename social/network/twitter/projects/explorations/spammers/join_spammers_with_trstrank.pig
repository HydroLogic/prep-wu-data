%default TRST '/data/sn/tw/fixd/pagerank/trstrank'
%default SPAM '/tmp/spammers'
%default OUT  '/tmp/spammers_with_tq'
        
trstrank = LOAD '$TRST' AS (sn:chararray, uid:long, rank:float, tq:int);        
spammers = LOAD '$SPAM' AS (sn:chararray);

joined = JOIN trstrank BY sn, spammers BY sn using 'replicated';
out    = FOREACH joined GENERATE spammers::sn AS sn, trstrank::uid AS uid, trstrank::rank AS rank, trstrank::tq AS tq;

rmf $OUT;
STORE out INTO '$OUT';
