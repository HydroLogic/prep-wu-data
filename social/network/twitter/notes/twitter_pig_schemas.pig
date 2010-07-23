--
-- Use these to load twitter models, stop all that retyping!
--

-- DEFAULT PATHS:
%default TW_OBJ_PATH '/data/sn/tw/fixd/objects'                   
        
-- SCHEMAS
follows                = LOAD '$TW_OBJ_PATH/a_follows_b'            	AS (rsrc:chararray, user_a_id:long, user_b_id:long);
favorites              = LOAD '$TW_OBJ_PATH/a_favorites_b'          	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long);
replies                = LOAD '$TW_OBJ_PATH/a_replies_b'            	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long,    in_reply_to_twid:long);
atsigns                = LOAD '$TW_OBJ_PATH/a_atsigns_b'            	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long);
retweets               = LOAD '$TW_OBJ_PATH/a_retweets_b'           	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long,    plz_flag:int);
retweets_name          = LOAD '$TW_OBJ_PATH/a_retweets_b_name'      	AS (rsrc:chararray, user_a_id:long, user_b_name:chararray, twid:long,    plz_flag:int);
atsigns_name           = LOAD '$TW_OBJ_PATH/a_atsigns_b_name'       	AS (rsrc:chararray, user_a_id:long, user_b_name:chararray, twid:long);
tweet                  = LOAD '$TW_OBJ_PATH/tweet'                  	AS (rsrc:chararray, twid:long,      crat:long,             uid:long,     sn:chararray,            sid:long,          in_reply_to_uid:long, in_reply_to_sn:chararray,     in_reply_to_sid:long,       in_re_twid:long, text:chararray,        src:chararray,              iso:chararray,      lat:float, lon:float, was_stw:int);
dtweet                 = LOAD '$TW_OBJ_PATH/delete_tweet'           	AS (rsrc:chararray, twid:long,      crat:long,             uid:long,     sn:chararray);                                                                                                                                                                                                          
search_id              = LOAD '$TW_OBJ_PATH/twitter_user_search_id' 	AS (rsrc:chararray, sid:long,       sn:chararray);                                                                                                                                                                                                                                           
user                   = LOAD '$TW_OBJ_PATH/twitter_user'           	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, prot:int,                followers:int,     friends:int,          statuses:int,                 favs:int,                   crat:long);                                                                             
partial                = LOAD '$TW_OBJ_PATH/twitter_user_partial'   	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, prot:int,                followers:int,     name:chararray,       url:chararray,                location:chararray,         description:chararray, profile_img_url:chararray);                                       
profile                = LOAD '$TW_OBJ_PATH/twitter_user_profile'   	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, name:chararray,          url:chararray,     location:chararray,   description:chararray,        time_zone:chararray,        utc:chararray);                                                                           
style                  = LOAD '$TW_OBJ_PATH/twitter_user_style'     	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, bg_col:chararray,        txt_col:chararray, link_col:chararray,   sidebar_border_col:chararray, sidebar_fill_col:chararray, bg_tile:chararray,     bg_img_url:chararray,       img_url:chararray);                         
userid                 = LOAD '$TW_OBJ_PATH/twitter_user_id'        	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, prot:int,                followers:int,     friends:int,          statuses:int,                 favs:int,                   crat:long,             sid:long,                   is_full:int,        health:chararray);
location               = LOAD '$TW_OBJ_PATH/twitter_user_location'  	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, location:chararray);                                                                                                                                                                                                          
hashtag                = LOAD '$TW_OBJ_PATH/hashtag'                	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                           
smiley                 = LOAD '$TW_OBJ_PATH/smiley'                 	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                           
tweet_url              = LOAD '$TW_OBJ_PATH/tweet_url'              	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                           
stock_token            = LOAD '$TW_OBJ_PATH/stock_token'            	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                         
word_token             = LOAD '$TW_OBJ_PATH/word_token'             	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                          
geo                    = LOAD '$TW_OBJ_PATH/geo'                    	AS (rsrc:chararray, twid:long,      uid:long,              sn:chararray, crat:long,               lat:float,         lon:float,            place_id:chararray);
mapping                = LOAD '/data/sn/tw/fixd/users_table'        	AS (sn:chararray,   uid:long,       sid:long);


-- -- SCHEMAS
-- a_follows_b            = LOAD '$TW_OBJ_PATH/a_follows_b'           	AS (rsrc:chararray, user_a_id:long, user_b_id:long);
-- a_favorites_b          = LOAD '$TW_OBJ_PATH/a_favorites_b'         	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long);
-- a_replies_b            = LOAD '$TW_OBJ_PATH/a_replies_b'           	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long,    in_re_twid:long);
-- a_atsigns_b            = LOAD '$TW_OBJ_PATH/a_atsigns_b'           	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long);
-- a_retweets_b           = LOAD '$TW_OBJ_PATH/a_retweets_b'          	AS (rsrc:chararray, user_a_id:long, user_b_id:long,        twid:long,    plz_flag:int);
-- a_retweets_b_name      = LOAD '$TW_OBJ_PATH/a_retweets_b_name'     	AS (rsrc:chararray, user_a_id:long, user_b_name:chararray, twid:long,    plz_flag:int);
-- a_atsigns_b_name       = LOAD '$TW_OBJ_PATH/a_atsigns_b_name'      	AS (rsrc:chararray, user_a_id:long, user_b_name:chararray, twid:long);
-- tweet                  = LOAD '$TW_OBJ_PATH/tweet'                 	AS (rsrc:chararray, twid:long,      crat:long,             uid:long,     sn:chararray,            sid:long,          in_re_uid:long, in_re_sn:chararray,     in_re_sid:long,       in_re_twid:long, text:chararray,        src:chararray,              iso:chararray,      lat:float, lon:float, was_stw:int);
-- delete_tweet           = LOAD '$TW_OBJ_PATH/delete_tweet'          	AS (rsrc:chararray, twid:long,      crat:long,             uid:long,     sn:chararray);                                                                                                                                                                                                          
-- twitter_user_search_id = LOAD '$TW_OBJ_PATH/twitter_user_search_id'	AS (rsrc:chararray, sid:long,       sn:chararray);                                                                                                                                                                                                                                           
-- twitter_user           = LOAD '$TW_OBJ_PATH/twitter_user'          	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, prot:int,                followers:int,     friends:int,          statuses:int,                 favs:int,                   crat:long);                                                                             
-- twitter_user_partial   = LOAD '$TW_OBJ_PATH/twitter_user_partial'  	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, prot:int,                followers:int,     name:chararray,       url:chararray,                location:chararray,         description:chararray, profile_img_url:chararray);                                       
-- twitter_user_profile   = LOAD '$TW_OBJ_PATH/twitter_user_profile'  	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, name:chararray,          url:chararray,     location:chararray,   description:chararray,        time_zone:chararray,        utc:chararray);                                                                           
-- twitter_user_style     = LOAD '$TW_OBJ_PATH/twitter_user_style'    	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, bg_col:chararray,        txt_col:chararray, link_col:chararray,   sidebar_border_col:chararray, sidebar_fill_col:chararray, bg_tile:chararray,     bg_img_url:chararray,       img_url:chararray);                         
-- twitter_user_id        = LOAD '$TW_OBJ_PATH/twitter_user_id'       	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, prot:int,                followers:int,     friends:int,          statuses:int,                 favs:int,                   crat:long,             sid:long,                   is_full:int,        health:chararray);
-- twitter_user_location  = LOAD '$TW_OBJ_PATH/twitter_user_location' 	AS (rsrc:chararray, uid:long,       scrat:long,            sn:chararray, location:chararray);                                                                                                                                                                                                          
-- hashtag                = LOAD '$TW_OBJ_PATH/hashtag'               	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                           
-- smiley                 = LOAD '$TW_OBJ_PATH/smiley'                	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                           
-- tweet_url              = LOAD '$TW_OBJ_PATH/tweet_url'             	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                           
-- stock_token            = LOAD '$TW_OBJ_PATH/stock_token'           	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                         
-- word_token             = LOAD '$TW_OBJ_PATH/word_token'            	AS (rsrc:chararray, text:chararray, uid:long,              twid:long,    crat:long);                                                          
-- geo                    = LOAD '$TW_OBJ_PATH/geo'                   	AS (rsrc:chararray, twid:long,      uid:long,              sn:chararray, crat:long,               lat:float,         lon:float,            place_id:chararray);
-- ixd/users_table        = LOAD '/data/sn/tw/fixd/users_table'       	AS (sn:chararray,   uid:long,       sid:long);























        
