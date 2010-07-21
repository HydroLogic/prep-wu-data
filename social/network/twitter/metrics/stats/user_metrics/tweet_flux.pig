--
-- Get raw estimate of tweets in for every user. Needs to be divided by a users account age
--
%default FOLLOW  '/data/sn/tw/fixd/objects/a_follows_b'
%default USER    '/data/sn/tw/fixd/objects/twitter_user'
%default TWFLUX  '/data/sn/tw/fixd/graph/tweet_flux'
        
users   = LOAD '$USER'   AS (rsrc:chararray, uid:long, scrat:long, sn:chararray, prot:int, followers:long, friends:long, statuses:long, favs:long, crat:long);
follows = LOAD '$FOLLOW' AS (rsrc:chararray, user_a_id:long, user_b_id:long);

-- generate distribution of tweets coming in
cut_users = FOREACH users GENERATE uid, statuses;
receivers = COGROUP cut_users BY uid, follows BY user_b_id; -- need to get a list of people to send statuses to
tw_in     = FOREACH receivers GENERATE
                FLATTEN(follows.user_a_id)  AS uid,
                FLATTEN(cut_users.statuses) AS tweets_in
            ;

cogrpd    = COGROUP tw_in BY uid, cut_users BY uid;
tw_flux   = FOREACH cogrpd GENERATE group AS uid, FLATTEN(cut_users.statuses) AS tw_out, SUM(tw_in.tweets_in) AS tw_in;

rmf $TWFLUX;
STORE tw_flux INTO '$TWFLUX';