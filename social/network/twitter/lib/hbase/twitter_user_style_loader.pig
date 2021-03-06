--
-- Load Twitter User Style using pig and HBase TableOutputFormat
-- timestamp needs to be formatted to Unix Epoch Time to load into Hbase
--
register '/home/travis/dev/HbaseBulkloader/build/hbase_bulkloader.jar';
register '/usr/lib/hbase/lib/jline-0.9.94.jar';
register '/usr/lib/hbase/lib/guava-r05.jar';
register '/home/travis/dev/HbaseBulkloader/lib/joda-time-1.6.2.jar';

%default DATA  's3://s3hdfs.infinitemonkeys.info/data/sn/tw/fixd/current/twitter_user_style'
%default TABLE 'soc_net_tw_twitter_user'
%default CF    'style'

DEFINE CONVERT com.infochimps.hadoop.pig.datetime.StringFormatToUnix();  

data     = LOAD '$DATA' AS (rsrc:chararray, uid:long, scraped_at:long, screen_name:chararray, profile_background_color:chararray, profile_text_color:chararray, profile_link_color:chararray, profile_sidebar_border_color:chararray, profile_sidebar_fill_color:chararray, profile_background_tile:chararray, profile_background_image_url:chararray, profile_image_url:chararray, profile_use_background_image:chararray);
cut_data = FOREACH data GENERATE uid AS key, uid AS user_id, CONVERT(scraped_at), screen_name, profile_background_color, profile_text_color, profile_link_color, profile_sidebar_border_color, profile_sidebar_fill_color, profile_background_tile, profile_background_image_url, profile_image_url, profile_use_background_image;
STORE cut_data INTO '$TABLE' USING com.infochimps.hbase.pig.HBaseStorage('$CF:user_id $CF:scraped_at $CF:screen_name $CF:profile_background_color $CF:profile_text_color $CF:profile_link_color $CF:profile_sidebar_border_color $CF:profile_sidebar_fill_color $CF:profile_background_tile $CF:profile_background_image_url $CF:profile_image_url $CF:profile_use_background_image', '-timestamp_field 2' );

