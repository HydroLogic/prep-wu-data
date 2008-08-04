#!/usr/bin/env ruby
require 'imw/utils'
require 'twitter_names_model'
include IMW; IMW.verbose = true
require 'imw/dataset'
as_dset __FILE__

# Setup database
include DataSet.setup_connection

# --- FILE ----
# twitter_name
# file_date

# --- SIDE ----
# twitter_id                    <link href="http://twitter.com/statuses/user_timeline/1554031.rss" />
# real_name             fn      <div class="section"><address><ul class="about vcard entry-author"><li><span class="label">Name</span> <span class="fn">Philip Flip Kromer</span></li>
# Location              adr     <li><span class="label">Location</span> <span class="adr">iPhone: 30.290983,-97.736720</span></li>
# Web                   url     <li><span class="label">Web</span> <a href="http://infochimps.com" class="url" rel="me nofollow">http://infochimps...</a></li>
# Bio                   bio     <li id="bio"><span class="label">Bio</span> <span class="bio">Building tools to Organize and Explore massive information sources</span></li>
# stats
# - following_count             <div class="section"><ul class="stats"><li><span id="following_count" class="stats_count numeric">50</span>
# - followers_count             <span id="followers_count" class="stats_count numeric">49</span>
# - favorites_count             <span id="favourites_count" class="stats_count numeric">0</span>
# - updates_count               <span class="stats_count numeric">178</span><
#
# [following_names              <div class="section"><div id="friends"><span class="vcard"><a href="http://twitter.com/sinned" class="url" rel="contact" title="Dennis Yang"><img alt="Dennis Yang" class="photo fn" height="24" id="profile-image" src="http://s3.amazonaws.com/twitter_production/profile_images/41865892/dennis_grass_edit_mini.png" width="24" /></a>

# --- MAIN ---
#
# <div id="content" ><div class="wrapper">
#
#
# latest_update_time
# onpage_first_update
# onpage_replies_count
# onpage_atsign_count           <span class="entry-content"> @<a href
#
# status (title)                <div class="hfeed"><div class="desc hentry">
#                               <p class="entry-title entry-content">status: ... <a href="http://tinyurl.com/6j9qht">http://tinyurl.com/6j9qht</a></p>
# status_time                   <p class="meta entry-meta"><a ... class="entry-date" rel="bookmark"><abbr class="published" title="2008-07-26T04:36:46+00:00">2 days</abbr> ago</a>
# status_from                   from <a href="http://twitterfeed.com">twitterfeed</a> </p>
#
# [status_id, posting_user]
# status (body                  <div class="tab"><table class="doing" id="timeline" cellspacing="0">
# status_id                     <tr class="hentry" id="status_868589932"><td class="content"><span class="entry-content">
# [status_id, users_atsigned]   @<a href="/MLB">MLB</a>.tv
#                               </span>
# [status_id, date]             <span class="meta entry-meta"><a ... class="entry-date" rel="bookmark"><abbr class="published" title="2008-07-25T23:55:34+00:00">06:55 PM July 25, 2008</abbr></a>
# [status_id, fromsource]       from <a href="http://twitter.com/twinkleking">Twinkle</a>
# [status_id, users_inreplyto]  <a href="http://twitter.com/MLB/statuses/193059672">in reply to MLB</a>
# [status_id, links]
#
#
# profile_image_url     ...     <h2 class="thumb" style='margin-bottom:25px'><a href="/account/profile_image/mrflip"><img alt="" border="0" id="profile-image" src="http://s3.amazonaws.com/twitter_production/profile_images/53592498/n877310082_2142521_5078_bigger.jpg" valign="middle" /></a>mrflip</h2><div class="clear"></div>
#                               http://s3.amazonaws.com/twitter_production/profile_images/41865892/dennis_grass_edit_bigger.png
# profile_image_url_mini        http://s3.amazonaws.com/twitter_production/profile_images/51596541/n712034_31126613_799_1__mini.jpg
# background_image_url          http://s3.amazonaws.com/twitter_production/profile_background_images/2348065/2005Mar-AustinTypeTour-075_-_Rappers_Delight_Raindrop.jpg
#
# style:
#  link_color                   a {color: #0000ff;}
#  name_color                   h2.thumb, h2.thumb a {color: #6C0000;}
#  text_color                   body { color: #000000;
#  bg_color                     background-color: #BCC0C8;
#  bg_image                     background: #BCC0C8 url(http://s3.amazo...)
#  bg_image_tile                fixed no-repeat top left;;
#  sidebar_fill_color           #side .notify { border: 1px solid #87bc44; }
#  sidebar_border_color         #side .promo { border: 1px solid #87bc44; }
#
#

