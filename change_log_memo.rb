#!/usr/bin/env ruby

def write_to_changelog(memo, date)
  write_date(date)
  write_memo(memo)
end

def write_date(date)
  return if date.nil?

  File.open(ENV["HOME"] + "/ChangeLog", "a") do |file|
    file.write "\n" + date + "\n"
  end
end

def write_memo(memo)
  return if memo.nil?

  File.open(ENV["HOME"] + "/ChangeLog", "a") do |file|
    file.write "\n  * " + memo + "\n"
  end
end

write_to_changelog(ARGV[0], ARGV[1])
