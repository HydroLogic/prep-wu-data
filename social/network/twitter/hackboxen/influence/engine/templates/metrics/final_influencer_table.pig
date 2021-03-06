--
-- Caculate full influencer metrics table based on todays date
--
metrics    = LOAD '$METRICS' AS (sn:chararray, uid:long, crat:long, followers:float, friends:float, fo_o:float, fo_i:float, at_o:float, at_i:float, re_o:float, re_i:float, rt_o:float, rt_i:float, tw_o:float, tw_i:float, ms_tw_o:float, hsh_o:float, sm_o:float, url_o:float, at_tr:float, fo_tr:float);
metrics_fg = FOREACH metrics {
               days_since   = $TODAY - (crat / 1000000l);
               feedness     = url_o / ms_tw_o;
               interesting  = (5.0f*at_i) / tw_o;
               sway         = (5.0f*rt_i) / tw_o;
               chattiness   = at_o / ms_tw_o;
               enthusiasm   = rt_o / ms_tw_o;
               influx       = tw_i / (float)days_since;
               outflux      = tw_o / (float)days_since;
               follow_churn = fo_o / friends;
               follow_rate  = friends / (float)days_since;
               GENERATE
                 uid          AS user_id,
                 sn           AS screen_name,
                 crat         AS created_at,
                 followers    AS followers,
                 influx       AS tweet_influx,
                 outflux      AS tweet_outflux,
                 enthusiasm   AS enthusiasm,
                 interesting  AS interesting,
                 feedness     AS feedness,
                 chattiness   AS chattiness,
                 sway         AS sway,
                 follow_rate  AS follow_rate,
                 follow_churn AS follow_churn,
                 at_tr        AS mention_trstrank,
                 fo_tr        AS follower_trstrank
               ;
             };

metrics_filtered = FILTER metrics_fg BY user_id IS NOT NULL;
metrics_distinct = DISTINCT metrics_filtered;

STORE metrics_distinct INTO '$METRICS_TABLE';
