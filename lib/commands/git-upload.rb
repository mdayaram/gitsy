
module Gitsy
  class GitUpload

    def initialize(config)
      @config = config
    end
    
    def run(args)
      # The project argument comes in wrapped with single
      # quotes, lets remove them.
      project = args[0].gsub(/^'*/, "")
      project = project.gsub(/'*$/, "")
      if !can_upload?(project)
        raise "You do not have access to pull this project."
      end

      Dir.chdir(@config.repo_root)
      Kernel.exec "git", "shell", "-c", "git-upload-pack #{args.join(" ")}"
    end

    def can_upload?(project)
      true
    end

    def self.to_s
      "git-upload-pack"
    end

  end
end
