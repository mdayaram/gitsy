require 'pathname'
require_relative '../checks/admin'

module Gitsy
  class Commands
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
        # First argument will be the user that's running, then any others.
        Kernel.exec "#{@executable} #{@env.config.user} #{args.join(" ")}"
      end

      def default?
        @default
      end

      def to_s
        @name
      end

    end
  end
end
