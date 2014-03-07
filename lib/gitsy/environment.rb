require 'fileutils'
require_relative 'logger'
require_relative 'config'

module Gitsy
  class Environment

    @@config_dir = File.expand_path(File.join(ENV["HOME"], ".gitsy"))
    @@template = File.expand_path(File.join(File.dirname(__FILE__), "../template"))

    def initialize(env, user)
      @logger = Logger.new
      setup(@@template, @@config_dir)
      @config = Config.new(@@config_dir, user)
    end

    # If our .gitsy folder doesn't exist, create it with our template.
    def setup(template_path, config_path)
      if !File.directory? config_path and !File.exists? config_path
        logger.info "Config path #{config_path} was not found, creating from template..."
        FileUtils.mkdir_p(config_path)
        FileUtils.cp_r(Dir[File.join(template_path, "*")], config_path)
      elsif !File.directory? config_path
        err_msg = "Config path #{config_path} exists, but is not a valid gitsy "
        err_msg += "configuration directory.  Delete it to create a new one from a template."
        logger.error err_msg
        raise "Gitsy is not configured correctly. Please check the logs for more details."
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
