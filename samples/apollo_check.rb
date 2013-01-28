#!/usr/bin/env ruby

#############################################
# Arg List:
#
# [1]: User
# [2]: Account/Project
# [3]: R|W
#

require 'net/http'
require 'uri'

if ARGV.length < 3
  puts "Invalid call, need user, account/project, access args."
  exit 2
end

user = ARGV[0]
account = ARGV[1].split("/")[0]
project = ARGV[1].split("/")[1]
perm = ARGV[2].upcase
apollo_domain = "apollo-vc01"

begin
  url = "http://#{apollo_domain}/nosaka/git_access_check?user=#{user}&account=#{account}&project=#{project}&access=#{perm}"
  response = Net::HTTP.get_response(URI.parse(url))
rescue Exception => e
  exit 2
end

if response.code != "200"
  exit 1
end

puts "Access granted to #{account}/#{project} for #{user}"
