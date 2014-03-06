module Gitsy
  class Commands
    class Default

      def initialize(env, commands)
        @env = env
        @command = nil
        commands.each do |name, cmd|
          @command = cmd if cmd.default?
        end
      end

      def can_exec?(args)
        @command.can_exec?(args) if !@command.nil?
      end
      
      def run(args)
        @command.run(args) if !@command.nil?
      end

      def default?
        false
      end

      def self.to_s
        "default"
      end

    end
  end
end
