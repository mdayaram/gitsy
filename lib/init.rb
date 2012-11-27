#!/usr/bin/env ruby

# In case you're running ruby version <= 1.8.7
unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.expand_path(File.dirname(caller[0])), path.to_str)
    end
  end
end
