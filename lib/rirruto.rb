require 'ostruct'
require 'open-uri'
require 'rss/1.0'
require 'rss/2.0'

def require_local(*filez)
  filez.to_a.each do |file|
    require File.join(File.dirname(__FILE__), file)
  end
end

module Rirruto
  # erm whatevs
  def self.run
    #feeds = Feed::Base.feedlist

    #abort("No feeds") unless feeds

    #loop do
    #  feeds.each do |feed|
    #    feed.parse.posts.each {|post| post.to_email}
    #  end

    #  sleep 600 # sleep less here and set check time in each feed
    #end
  end
end

local_filez = ["ext", "rirruto/feed", "rirruto/mail"]
require_local *local_filez
