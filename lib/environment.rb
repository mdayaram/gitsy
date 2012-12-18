require_relative 'logger'
require_relative 'config'

module Gitsy
  class Environment

    def initialize(env, user)
      @config = Config.new(env, user)
      @logger = Logger.new
      @@instance = self
    end

    ##############
    #i Confings
    ##############

    def config
      @config
    end

    def self.config
      @@instance.config
    end

    ######################
    # User Visible Output
    ######################

    def puts (msg)
      $stderr.puts msg
    end

    def self.puts(msg)
      @@instance.puts msg
    end

    ##############
    # Logging
    ##############

    def logger
      @logger
    end
    
    def self.logger
      @@instance.logger
    end
  end
end
