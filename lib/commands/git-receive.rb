require_relative '../checks/project'

module Gitsy
  class GitReceive

    def initialize(config)
      @config = config
    end

    def can_exec?(args)
      # The project argument comes in wrapped with single
      # quotes, lets remove them.
      project = args[0].gsub(/^'*/, "")
      project = project.gsub(/'*$/, "")

      Checks::Project.check?(@config, project, true)
    end

    def run(args)
      # The project argument comes in wrapped with single
      # quotes, lets remove them.
      project = args[0].gsub(/^'*/, "")
      project = project.gsub(/'*$/, "")

      # If repo doesn't exist, create it.
      repo_dir = File.join(@config.repo_root, "#{project}.git")
      if !File.exists? repo_dir
        Debug.puts("Repo doesn't exist, initializing...")

        cmd_str = "git init --bare #{repo_dir} "
        if @config.template_dir?
          cmd_str += "--template #{@config.template_dir} "
        end

        if !Kernel.system("#{cmd_str} >&2")
          raise "Couldn't initialize new repo #{project}!"
        end
      end

      Dir.chdir(@config.repo_root)
      Kernel.exec "git", "shell", "-c", "git-receive-pack #{args.join(" ")}"
    end

    def self.to_s
      "git-receive-pack"
    end

  end
end
