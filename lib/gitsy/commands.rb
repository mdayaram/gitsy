require 'gitsy/commands/git-receive'
require 'gitsy/commands/git-upload'
require 'gitsy/commands/custom'
require 'gitsy/commands/default'

module Gitsy
  class Commands

    def initialize(env)
      @env = env
      @@commands = Hash.new

      @env.config.commands.each do |cmd, options|
        @@commands[cmd] = Custom.new(env, cmd, options)
      end
      
      @@commands[GitReceive.to_s] = GitReceive.new(env)
      @@commands[GitUpload.to_s] = GitUpload.new(env)
      @@commands[Default.to_s] = Default.new(env, @@commands)
    end

    def exec(complete_cmd)
      if complete_cmd.nil? || complete_cmd.empty?
        complete_cmd = Default.to_s
      end

      cmd, *args = complete_cmd.split
      
      if @@commands[cmd].nil?
        cmd = Default.to_s
        @env.logger.error "Command '#{complete_cmd}' not found, running default."
      end
      
      if !@@commands[cmd].can_exec?(args)
        raise "Permission denied."
      end

      @@commands[cmd].run(args)
    end

  end
end
