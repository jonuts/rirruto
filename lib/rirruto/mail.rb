module Rirruto::Mail
  def self.send_msg(profile, msg)
    begin
      Net::SMTP.start(profile.servername, profile.serverport) do |smtp|
        smtp.send_message msg.formatted_email, msg.from[1], msg.to[1]
      end
    rescue Errno::ECONNREFUSED
      puts "Your smtp settings suck"
    end
  end
end

require_local "rirruto/mail/profile", "rirruto/mail/message"
