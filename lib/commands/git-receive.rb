require_relative '../checks/project'

module Gitsy
  class GitReceive

    def initialize(config)
      @config = config
    end
    
    def run(args)
      # The project argument comes in wrapped with single
      # quotes, lets remove them.
      project = args[0].gsub(/^'*/, "")
      project = project.gsub(/'*$/, "")

      if !Checks::Project.check?(@config, project, true)
        raise "You do not have access for this repo."
      end

      # If repo doesn't exist, create it.
      repo_dir = File.join(@config.repo_root, "#{project}.git")
      if !File.exists? repo_dir
        Debug.puts("Repo doesn't exist, initializing...")
        if !Kernel.system("git init --bare #{repo_dir} >&2")
          raise "Couldn't initialize new repo #{project}!"
        end
      end

      Dir.chdir(@config.repo_root)
      Kernel.exec "git", "shell", "-c", "git-receive-pack #{args.join(" ")}"
    end

    def can_receive?(project)
      # Add call to apollo check
      true
    end

    def self.to_s
      "git-receive-pack"
    end

  end
end
