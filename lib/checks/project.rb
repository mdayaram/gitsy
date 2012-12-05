require 'pathname'

module Gitsy
  module Checks
    class Project

      def self.check?(config, project, write)
        return true if !config.project_check?

        cmd = config.project_check
        if !Pathname.new(config.project_check).absolute?
          cmd = File.join(
            File.expand_path(File.dirname(__FILE__)),
            "../../ext",
            config.project_check)
        end

        cmd += " #{config.user} #{project}"
        cmd += " W" if write
        cmd += " R" if !write

        Kernel.system cmd
      end

    end
  end
end
