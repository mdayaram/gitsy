require 'yaml'

module Gitsy
  class Config

    def initialize(environment, user)
      config_file = File.join(File.dirname(__FILE__), "../config.yml")
      @config = YAML.load(File.open(config_file))[environment]
      @config["user"] = user
    end
    
    def method_missing method_id, *args
      if !@config[method_id.to_s].nil?
        return @config[method_id.to_s]
      end
      super
    end
  end
end
