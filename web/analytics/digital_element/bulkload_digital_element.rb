#!/usr/bin/env ruby
require 'rubygems'
require 'wukong'
require 'json'
require 'wukong/periodic_monitor'

Settings.define :dataset,    :required => true

#
# cat /data/fixd/digital_element/demographics.tsv | ~/ics/icsdata/web/analytics/digital_element/bulkload_digital_element.rb --map --dataset=web_an_de_demo > /tmp/bulkload_de_web_an_de_demo.log 2>&1
#

module TokyoDbConnection
  class TyrantDb
    DB_SERVERS = [
        '10.194.101.156',
        '10.196.73.156',
        '10.196.75.47',
        '10.242.217.140',
    ].freeze

    DB_PORTS = {
      # :tw_screen_names  => 12002,
      # :tw_search_ids    => 12003,
      # #
      # :tw_user_info     => 14000,
      # :tw_wordbag       => 14101,
      # :tw_influence     => 14102,
      # :tw_trstrank      => 14103,
      # :tw_conversation  => 14104,
      # #
      # :tw_screen_names2 => 12004,
      # :tw_search_ids2   => 12005,
      # #
      # :tw_user_info2    => 14200,
      # :tw_wordbag2      => 14201,
      # :tw_influence2    => 14202,
      # :tw_trstrank2     => 14203,
      # :tw_conversation2 => 14204,
      # :tw_strong_links2 => 14205,
      # :tw_word_stats2   => 14210,
      # #
      # :ip_geo_census    => 14400,
      #
      :web_an_de_demographics => 14411,
      :web_an_de_domain       => 14412,
      :web_an_de_geo          => 14413,
    }
  end
end
require 'wukong/keystore/tyrant_db'

class Mapper < Wukong::Streamer::LineStreamer
  def process line, &block
    key, recs = line.split("\t", 2)
    db.insert(key, recs)
    log.periodically{ print_progress(key, recs) }
  end

  # track progress --
  #
  # NOTE: emits to stdout, since other output is going to DB
  #
  def print_progress *args
    Log.info log.progress(db.size, *args)
  end
  # Used to log progress periodically
  def log
    @log ||= PeriodicMonitor.new(options)
  end
  # track progress --
  def after_stream
    print_progress
  end
  def db
    @db ||= TokyoDbConnection::TyrantDb.new(Settings.dataset.to_sym)
  end

end

Wukong::Script.new(Mapper, nil).run