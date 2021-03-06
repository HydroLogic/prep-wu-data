#!/usr/bin/env ruby
require 'rubygems'
require 'wukong'
require 'json'
require 'wukong/periodic_monitor'

#
# Load precomputed json data into the ApeyEye database.
#
#   ~/ics/icsdata/social/network/twitter/apeyeye/bulk_load_conversation.rb --log_interval=1000 --run --rm /data/sn/tw/fixd/objects/a_replies_b /data/sn/tw/fixd/apeyeye/conversation/a_replies_b_json
#
class SimpleMapper < Wukong::Streamer::RecordStreamer
  def process rsrc, user_a_id, user_b_id, tweet_id, re_tweet_id='', *args
    return if (user_a_id.to_i == 0) || (user_b_id.to_i == 0) || (tweet_id.to_i == 0)
    re_tweet_id = '' if re_tweet_id.to_i == 0
    yield [rsrc, user_a_id, user_b_id, tweet_id, re_tweet_id, *args].compact
  end
end

class BulkLoader < Wukong::Streamer::AccumulatingReducer
  attr_accessor :a_replies_b

  def initialize *args
    super *args
    Settings.deep_merge! options
    @iter = 0
    @log = PeriodicMonitor.new
  end

  def get_key rsrc, user_a_id, user_b_id, *_
    [user_a_id, user_b_id]
  end

  def start! *args
    self.a_replies_b = []
  end

  def accumulate rsrc, user_a_id, user_b_id, *info
    return if (user_a_id.to_i == 0) || (user_b_id.to_i == 0)
    self.a_replies_b << info.reject(&:blank?).map(&:to_i)
  end

  def finalize &block
    return if self.key.blank?
    user_a_id, user_b_id = self.key
    return if (user_a_id.to_i == 0) || (user_b_id.to_i == 0)
    self.a_replies_b.uniq!
    value_hsh      = { :user_a_id => user_a_id.to_i, :user_b_id => user_b_id.to_i, :a_replies_b => a_replies_b }
    value_hsh_json = value_hsh.to_json
    yield [user_a_id, user_b_id, value_hsh_json]
    @log.periodically
  end

end

Wukong::Script.new(
  SimpleMapper,
  BulkLoader,
  :sort_fields => 3,
  :partition_fields => 3
  ).run
