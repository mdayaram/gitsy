require_relative '../checks/project'

module Gitsy
  class GitReceive

    def initialize(env)
      @env = env
    end

    def can_exec?(args)
      # The project argument comes in wrapped with single
      # quotes, lets remove them.
      project = args[0].gsub(/^'*/, "")
      project = project.gsub(/'*$/, "")

      Checks::Project.check?(@env, project, true)
    end

    def run(args)
      # The project argument comes in wrapped with single
      # quotes, lets remove them.
      project = args[0].gsub(/^'*/, "")
      project = project.gsub(/'*$/, "")

      # If repo doesn't exist, create it.
      repo_dir = File.join(@env.config.repo_root, "#{project}.git")
      if !File.exists? repo_dir
        @env.puts("Repo doesn't exist, initializing...")
        @env.logger.info "Repository #{repo_dir} doesn't exist, initializing..."

        cmd_str = "git init --bare #{repo_dir} "
        if @env.config.template_dir?
          tmp_dir = @env.config.template_dir
          cmd_str += "--template #{tmp_dir} "
        end

        if !Kernel.system("#{cmd_str} >&2")
          raise "Couldn't initialize new repo #{project}!"
        end

        link_hooks(repo_dir)
        link_config(repo_dir)
      end

      Dir.chdir(@env.config.repo_root)
      Kernel.exec "git", "shell", "-c", "git-receive-pack #{args.join(" ")}"
    end

    def default?
      false
    end

    def self.to_s
      "git-receive-pack"
    end

    private

    def link_hooks(repo_path)
      if @env.config.link_template_hooks?
        link_hooks_path = File.join(repo_path, "hooks")
        hooks_path = File.expand_path(@env.config.link_template_hooks)
        FileUtils.rm_rf(link_hooks_path)
        File.symlink(hooks_path, link_hooks_path)
      end
    end

    def link_config(repo_path)
      if @env.config.link_template_config?
        link_config_path = File.join(repo_path, "config")
        config_path = File.expand_path(@env.config.link_template_config)
        FileUtils.rm_rf(link_config_path)
        File.symlink(config_path, link_config_path)
      end
    end

  end
end
