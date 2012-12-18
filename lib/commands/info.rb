
module Gitsy
  class Info

    def initialize(env)
      @env = env
      @message = "\nHi #{@env.config.user}! You've successfully authenticated, "
      @message += "but #{@env.config.company} does not provide shell access.\n"
    end

    def can_exec?(args)
      # You can always run info!
      true
    end
    
    def run(args)
      Kernel.exec "echo", "-e", "#{@message}"
    end

    def self.to_s
      "info"
    end

  end
end
