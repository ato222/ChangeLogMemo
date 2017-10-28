#!/usr/bin/env ruby

require "fileutils"

def write_to_changelog(memo)
  write_date
  write_memo memo
end

def write_date
  return if check_if_wrote_today

  today = Time.now.strftime("%Y-%m-%d").to_s
  File.open(ENV["HOME"] + "/ChangeLog", "a") do |file|
    file.write "\n" + today + " Foo bar <foobar@hoge.com>" + "\n"
  end

  update_wrote_log
end

def check_if_wrote_today
  unless File.exist?("./pre_wrote_time_log.txt")
    FileUtils.touch("./pre_wrote_time_log.txt")
  end

  today = Time.now.strftime("%Y-%m-%d").to_s
  File.open("./pre_wrote_time_log.txt") do |file|
    pre_date = file.read.strip
    if pre_date.empty? # first time
      return false
    end

    (today == pre_date) ? true : false;
  end
end

def update_wrote_log
  today = Time.now.strftime("%Y-%m-%d").to_s
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


write_to_changelog(ARGV[0])
