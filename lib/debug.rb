require 'syslog'

module Gitsy
  class Debug

    def initialize()
      # Open syslog with options=3 and facility=4
      # Facility 4 is what we log to for logstash to be able to see it.
      # Not sure what options 3 is, but it's the default for the syslog package.
      Syslog.open "gitsy", 3, 4
    end

    @@instance = Debug.new
    def self.log(msg)
      @@instance.log_message(msg)
    end

    def self.puts(msg)
      $stderr.puts msg
    end

    def self.p(msg)
      $stderr.puts msg.inspect
    end

    def log_message(msg)
      Syslog.log 0, msg
    end

    private_class_method :new

  end
end
