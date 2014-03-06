require 'yaml'

module Gitsy
  class Config

    def initialize(config_dir, user)
      config_file = File.join(config_dir, "config.yml")
      @config = YAML.load(File.open(config_file))
      @config["user"] = user
    end
    
    def method_missing method_id, *args
      # Check for a key in our config first.
      if !@config[method_id.to_s].nil?
        return @config[method_id.to_s]
      end

      # if method name ends in a question mark, check
      # if a config exists after removing question mark.
      if method_id.to_s[-1, 1] == "?"
        key = method_id.to_s.chop
        return !@config[key].nil?
      end

      #super
    end
  end
end
