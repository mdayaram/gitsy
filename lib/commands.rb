require_relative 'commands/git-receive'
require_relative 'commands/git-upload'
require_relative 'commands/info'

module Gitsy
  class Commands

    def initialize(config)
      @@commands = Hash.new
      @@commands[GitReceive.to_s] = GitReceive.new(config)
      @@commands[GitUpload.to_s] = GitUpload.new(config)
      @@commands[Info.to_s] = Info.new(config)
    end

    def exec(complete_cmd)
      if complete_cmd.nil? || complete_cmd.empty?
        complete_cmd = "info"
      end

      cmd, *args = complete_cmd.split
      
      c = @@commands[cmd]
      if c.nil?
        c = @@commands["info"]
      end
      
      if !c.can_exec?(args)
        raise "Permission denied."
      end

      c.run(args)
    end

  end
end
