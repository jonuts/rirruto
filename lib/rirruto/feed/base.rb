class Rirruto::Feed::Base
  class << self
    attr_reader :feedlist, 
                :url, 
                :creds, 
                :title, 
                :posts, 
                :storage, 
                :profile,
                :first_run,
                :interval,
                :last_check,
                :next_check

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

    def check_every(time)
      @interval = time
    end

    def store_with(way)
      @storage = way
    end
  end

  def self.parse
    if @next_check && Time.now > @next_check
      @response = retrieve
    end

    rss = ::RSS::Parser.parse(@response)
    @title     ||= rss.channel.title
    @first_run ||= []
    @posts     ||= []

    store = @first_run.empty? ? @first_run : @posts
    rss.items.each do |post|
      create_post(post, store)
    end

    self
  end

  def self.mailer
    profile.constantize
  end

  def self.reset(*vars)
    vars.to_a.each {|v| instance_variable_set(:"@#{v}", nil)}
  end

  private

  def self.create_post(item, store)
    post = Rirruto::Feed::Post.new :feed_name => name

    [:title, :link, :description, :date].each do |meth|
      post.send(:"#{meth}=", item.send(meth)) if item.respond_to?(meth)
    end

    if store == @posts
      store << post if post.valid?
    else
      store << post
    end
  end

  def self.retrieve
    opts = {}
    opts.merge!({:http_basic_authentication => [*creds]}) if creds
    open(url, opts).read
    @last_check = Time.now
    @next_check = @last_check + @interval
  end
end

