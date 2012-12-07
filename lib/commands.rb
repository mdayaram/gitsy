require_relative 'commands/git-receive'
require_relative 'commands/git-upload'
require_relative 'commands/info'
require_relative 'commands/moov_check'

module Gitsy
  class Commands

    def initialize(config)
      @@commands = Hash.new
      @@commands[GitReceive.to_s] = GitReceive.new(config)
      @@commands[GitUpload.to_s] = GitUpload.new(config)
      @@commands[Info.to_s] = Info.new(config)
      @@commands[MoovCheck.to_s] = MoovCheck.new(config)
    end

    def exec(complete_cmd)
      if complete_cmd.nil? || complete_cmd.empty?
        complete_cmd = Info.to_s
      end

      cmd, *args = complete_cmd.split
      
      if @@commands[cmd].nil?
        cmd = Info.to_s
      end
      
      if !@@commands[cmd].can_exec?(args)
        raise "Permission denied."
      end

      @@commands[cmd].run(args)
    end

  end
end
