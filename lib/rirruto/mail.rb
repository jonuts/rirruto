module Rirruto::Mail
  def self.add_to_queue(msg)
    @queue << msg
  end

  def self.queue
    @queue
  end

  def self.send_me(profile, msg)
    begin
      Net::SMTP.start(profile.servername, profile.serverport) do |smtp|
        smtp.send_message msg, profile.from, profile.to
      end
    rescue Errno::ECONNREFUSED
      puts "Your smtp settings suck"
    end
  end
end

require_local "rirruto/mail/profile", "rirruto/mail/message"
