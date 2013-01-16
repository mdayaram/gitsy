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
    # Confings
    ##############

    def config
      @config
    end

    def self.config
      @@instance.config
    end

    def gitsy_root
      File.expand_path(File.join(File.dirname(__FILE__), '..'))
    end

    def self.gitsy_root
      @@instance.gitsy_root
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
