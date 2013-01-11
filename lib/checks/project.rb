require 'pathname'

module Gitsy
  module Checks
    class Project

      def self.check?(env, project, write)
        return true if !env.config.project_check?

        cmd = env.config.project_check
        if !Pathname.new(env.config.project_check).absolute?
          cmd = File.join(env.gitsy_root, env.config.project_check)
        end

        if File.exists? cmd
          cmd += " #{env.config.user} #{project}"
          cmd += " W" if write
          cmd += " R" if !write
          cmd += " >&2" # ensure all output goes to stderr.

          return Kernel.system cmd
        end
        return false
      end

    end
  end
end
