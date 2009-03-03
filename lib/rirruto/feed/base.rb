class Rirruto::Feed::Base
  class << self
    attr_reader :feedlist, 
                :url, 
                :creds, 
                :title, 
                :posts, 
                :storage, 
                :profile

    def inherited(feed)
      superclass.inherited(feed) if superclass.respond_to? :inherited
      (@feedlist ||= []) << feed
    end

    def feed_url(url)
      @url = url
    end

    def feed_title(title)
      @title = title
    end

    def using_creds(*creds)
      @creds = *creds
    end

    def mail_profile(profile)
      @profile = profile
    end

    def store_with(way)
      @storage = way
    end
  end

  def self.parse
    @response ||= retrieve
    rss = ::RSS::Parser.parse(@response)
    @title ||= rss.channel.title
    @posts ||= []

    rss.items.each do |post|
      create_post(post) if post.valid?
    end

    self
  end

  def self.mailer
    profile.constantize
  end

  def self.reset(*vars)
    vars.to_a.each {|v| v = nil}
  end

  private

  def self.create_post(item)
    post = Rirruto::Feed::Post.new :feed_name => name

    [:title, :link, :description, :date].each do |meth|
      post.send(:"#{meth}=", item.send(meth)) if item.respond_to?(meth)
    end

    @posts << post
  end

  def self.retrieve
    opts = {}
    opts.merge!({:http_basic_authentication => [*creds]}) if creds
    open(url, opts).read
  end
end

