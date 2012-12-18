#!/usr/bin/env ruby

require File.join(File.expand_path(File.dirname(__FILE__)), "../lib/init")

require_relative '../lib/environment'
require_relative '../lib/debug'
require_relative '../lib/commands'

module Gitsy
  environment = Environment.new(ARGV[0], ARGV[1])
  begin
    Commands.new(environment).exec(ENV["SSH_ORIGINAL_COMMAND"])
    # Anything here would not get executed.
  rescue Exception => e
    environment.puts e.message
  end
end
