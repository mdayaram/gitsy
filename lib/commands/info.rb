
module Gitsy
  class Info

    def initialize(config)
      @config = config
      @message = "Hi #{@config.user}!  You've successfully authenticated, "
      @message += "but Moovweb does not provide shell access."
    end
    
    def run(args)
      Kernel.exec "echo", "#{@message}"
    end

    def self.to_s
      "info"
    end

  end
end
