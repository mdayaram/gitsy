
module Gitsy
  class MoovCheck

    def initialize(config)
      @config = config
    end

    def can_exec?(args)
      # Everyone can run moov_check!
      true
    end
    
    def run(args)
      Kernel.exec "echo", "-e", "OK"
    end

    def self.to_s
      "moov_check"
    end

  end
end
