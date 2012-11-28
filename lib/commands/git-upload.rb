require_relative '../checks/project'

module Gitsy
  class GitUpload

    def initialize(config)
      @config = config
    end

    def can_exec?(args)
      # The project argument comes in wrapped with single
      # quotes, lets remove them.
      project = args[0].gsub(/^'*/, "")
      project = project.gsub(/'*$/, "")

      Checks::Project.check?(@config, project, false)
    end

    def run(args)
      Dir.chdir(@config.repo_root)
      Kernel.exec "git", "shell", "-c", "git-upload-pack #{args.join(" ")}"
    end

    def self.to_s
      "git-upload-pack"
    end

  end
end
