#!/usr/bin/env ruby

require "fileutils"
require "dotenv"

def write_to_changelog(memo)
  write_date
  write_memo memo
end

def write_date
  return if check_if_wrote_today

  File.open(ENV["HOME"] + "/ChangeLog", "a") do |file|
    username = (ENV['USERNAME'].nil?) ? "FooBarBaz" : ENV['USERNAME']
    email    = (ENV['EMAIL'].nil?) ? "foo@bar.baz" : ENV['EMAIL']
    file.write "\n" + today + " #{username} <#{email}>" + "\n"
    update_wrote_log
  end
end

def check_if_wrote_today
  unless File.exist?("./pre_wrote_time_log.txt") # first time
    FileUtils.touch("./pre_wrote_time_log.txt")
  end

  File.open("./pre_wrote_time_log.txt") do |file|
    pre_date = file.read.strip
    return false if pre_date.empty? # first time
    
    (today == pre_date) ? true : false;
  end
end

def update_wrote_log
  File.open("./pre_wrote_time_log.txt", "w+") do |file|
    file.write today
  end
end

def write_memo(memo)
  return if memo.nil?

  File.open(ENV["HOME"] + "/ChangeLog", "a") do |file|
    file.write "\n  * " + memo + "\n"
  end
end

def today
  Time.now.strftime("%Y-%m-%d").to_s
end

Dotenv.load
write_to_changelog(ARGV[0])
