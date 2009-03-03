class Rirruto::Mail::Profile
  class << self
    attr_reader :creds, 
                :servername, 
                :serverport, 
                :mail_from, 
                :mail_to

    def username(u)
      @creds ||= {}
      @creds[:user] = u
    end

    def password(p)
      @creds ||= {}
      @creds[:pass] = p
    end

    def server(s)
      @servername = s
    end

    def port(p)
      @serverport = p
    end

    def from(name, email)
      @mail_from = [name, email]
    end

    def to(name, email)
      @mail_to = [name, email]
    end
  end
end

