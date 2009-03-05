class Rirruto::Mail::Message < OpenStruct
  class << self ; attr_accessor :queue ; end

  # Creates a new email and adds it to the queue to be sent out
  #
  # ==== Parameters
  # The following should be set in the args hash:
  #   :to, :from, :subject, :body
  def initialize(args={})
    super
    add_self_to_queue
  end

  attr_accessor :sent

  def mailit
    Rirruto::Mail.send_msg(feed.mailer, self)
  end

  def sent?
    !!@sent
  end

  def formatted_email

%Q=
From: #{from[0]} <#{from[1]}>
To: #{to[0]} <#{to[1]}>
Subject: #{subject}
Date: #{date || Time.now}

#{body}
=

  end

  private

  def add_self_to_queue
    self.class.queue ||= []
    self.class.queue << self
  end
end

