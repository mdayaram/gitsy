require 'fileutils'
require_relative 'logger'
require_relative 'config'

module Gitsy
  class Environment

    @@config_dir = File.expand_path(File.join(ENV["HOME"], ".gitsy"))
    @@template = File.expand_path(File.join(File.dirname(__FILE__), "../template"))

    def initialize(env, user)
      setup(@@template, @@config_dir)
      @config = Config.new(@@config_dir, user)
      @logger = Logger.new
      @@instance = self
    end
    
    # If our .gitsy folder doesn't exist, create it with our template.
    def setup(template_path, config_path)
      if !File.directory? config_path and !File.exists? config_path
        FileUtils.mkdir_p(config_path)
        FileUtils.cp_r(Dir[File.join(template_path, "*")], config_path)
      elsif !File.directory? config_path
        raise "Cannot create gitsy configuration directory. #{config_path} exists but is not a directory."
      end
    end

    ##############
    # Configs
    ##############

    def config
      @config
    end

    def gitsy_conf
      @@config_dir
    end

    #################################
    # User Visible Output and Logging
    #################################

    def puts (msg)
      $stderr.puts msg
    end

    def logger
      @logger
    end
    
  end
end
