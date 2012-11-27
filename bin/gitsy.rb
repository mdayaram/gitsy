#!/usr/bin/env ruby

require File.join(File.expand_path(File.dirname(__FILE__)), "../lib/init")

require_relative '../lib/config'
require_relative '../lib/debug'
require_relative '../lib/commands'

module Gitsy

  config = Config.new(ARGV[0], ARGV[1])
  Commands.new(config).exec(ENV["SSH_ORIGINAL_COMMAND"])
  # Anything here would not get executed.

end
