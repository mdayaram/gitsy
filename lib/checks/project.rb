require 'pathname'

module Gitsy
  module Checks
    class Project

      def self.check?(env, project, write)
        return true if !env.config.project_check?

        # If the path is not absolute, prepend the gitsy root path to it.
        cmd = env.config.project_check
        if !Pathname.new(cmd).absolute?
          cmd = File.join(env.gitsy_root, cmd)
        end

        # If the file doesn't exist, maybe it's an executable in our PATH.
        if !File.exists? cmd
          cmd = env.config.project_check
        end

        cmd += " #{env.config.user} #{project}"
        cmd += " W" if write
        cmd += " R" if !write
        cmd += " >&2" # ensure all output goes to stderr.

        return Kernel.system cmd
      end

    end
  end
end
