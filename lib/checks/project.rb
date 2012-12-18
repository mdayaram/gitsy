require 'pathname'

module Gitsy
  module Checks
    class Project

      def self.check?(env, project, write)
        return true if !env.config.project_check?

        cmd = env.config.project_check
        if !Pathname.new(env.config.project_check).absolute?
          cmd = File.join(
            File.expand_path(File.dirname(__FILE__)),
            "../../ext",
            env.config.project_check)
        end

        cmd += " #{env.config.user} #{project}"
        cmd += " W" if write
        cmd += " R" if !write
        cmd += " >&2" # ensure all output goes to stderr.

        Kernel.system cmd
      end

    end
  end
end
