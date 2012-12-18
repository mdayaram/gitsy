module Gitsy
  class Logger
    
    def log(level, msg)
      `logger -p local4.err "#{@hostname} gitsy[#{level}]: #{msg}"`
    end
    
    def info(msg)
      log("INFO", msg)
    end
    
    def error(msg)
      log("ERROR", msg)
    end
  end
end
