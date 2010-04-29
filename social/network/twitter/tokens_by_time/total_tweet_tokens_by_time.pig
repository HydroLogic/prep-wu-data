-- ===========================================================================
--
--   total_tweet_tokens_by_time.pig --
--
--   An count of how often hashtags, URLs or smileyfaces
--   have been observed in our corpus every hour, day, or month depending on TIMESLICE.
--

%default INPUT_DATA                '/data/rawd/social/network/twitter/census/tokens_by_hour'
%default OUTPUT_DATA               '/data/rawd/social/network/twitter/census/total_tokens_by_hour'

-- Divide created_at by: 10000.0 for hour, 1000000.0 for day, 100000000.0 for month.
%default TIMESLICE   10000.0

-- So we can use the LOWER function
REGISTER /usr/lib/pig/contrib/piggybank/java/piggybank.jar ;

TokensByTime = LOAD '$INPUT_DATA' AS (rsrc:chararray, crat_bin:long, num:long, text:chararray);

-- Token Totals by Hour
TokensWithoutText        = FOREACH TokensByTime GENERATE rsrc, crat_bin, num ;
TokenCountsByTime        = GROUP TokensWithoutText BY (rsrc, crat_bin) ;
SummedTokenCountsByTime  = FOREACH TokenCountsByTime GENERATE
  FLATTEN(group.rsrc)           AS rsrc,
  FLATTEN(group.crat_bin)       AS crat_bin,  
  SUM(TokensWithoutText.num)    AS num
  ;
  
TotalTokenCountsByTime = ORDER SummedTokenCountsByTime BY crat_bin, rsrc ;

rmf                               $OUTPUT_DATA;
STORE TotalTokenCountsByTime INTO '$OUTPUT_DATA';
