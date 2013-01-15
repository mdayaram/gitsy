require 'pathname'
require_relative '../checks/admin'

module Gitsy
  class Custom

    def initialize(env, cmd, value)
      @env = env
      @name = cmd
      if value.is_a? String
        @executable = value
        @admin_only = false
        @default = false
        return
      end

      if value["exec"].nil? or value["exec"].empty?
        raise "Command #{cmd} provided in config does not contain an executable."
      end
      @executable = value["exec"]
      @admin_only = value["admin_only"] == true
      @default = value["default"] == true
    end

    def can_exec?(args)
      return true if !@admin_only
      Checks::Admin.check?(@env)
    end
    
    def run(args)
      # If this is a path to an executable, check if it's absolute or relative.
      cmd = @executable
      if !Pathname.new(cmd).absolute?
        cmd = File.join(@env.gitsy_root, cmd)
      end

      # After resolving the relative path, if it doesn't exist, then it's
      # probably an executable in our PATH, so just run it straight up.
      if !File.exists? cmd
        cmd = @executable
      end

      # First argument will be the user that's running, then any others.
      Kernel.exec "#{cmd} #{@env.config.user} #{args.join(" ")}"
    end

    def default?
      @default
    end

    def to_s
      @name
    end

  end
end
