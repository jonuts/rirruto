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
    feeds = Feed::Base.feedlist

    abort("No feeds") unless feeds

    loop do
      feeds.each do |feed|
        feed.parse.posts.each {|post| post.to_email}
        until((q = Rirruto::Mail::Message.queue).empty?)
          msg = q.shift
          msg.mailit
          msg.sent = true
        end if Rirruto::Mail::Message.queue
      end

      sleep 10
    end
  end
end

local_filez = ["ext", "rirruto/feed", "rirruto/mail"]
require_local *local_filez
