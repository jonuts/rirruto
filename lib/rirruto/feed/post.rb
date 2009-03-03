class Rirruto::Feed::Post < OpenStruct

  IGNORE_LIST = %w(feed_name)

  def feed
    feed_name.constantize
  end

  def unique_methods
    singleton_methods.select {|m| ! m.index("=")} - IGNORE_LIST
  end

  def valid?
    feed.posts.all? do |post|
      post.unique_meths.all? do |meth|
        post.send(meth) != self.send(meth)
      end
    end
  end

  def to_email
    Rirruto::Mail::Message.new :from => feed.mailer.mail_from,
      :to      => feed.mailer.mail_to,
      :subject => title,
      :body    => description
  end
end

