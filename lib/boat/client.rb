module Boat 
  class Client
    def self.server
      @@server ||= "http://localhost:5678"
    end
    def self.server=(noah_server)
      @@server = noah_server
    end
    def self.timeout
      @@timeout ||= 15
    end
    def self.timeout=(timeout)
      @@timeout = timeout
    end
  end
end
