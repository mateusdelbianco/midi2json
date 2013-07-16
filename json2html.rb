require "rubygems"
require "json"

if ARGV[0].nil?
  puts "usage #{$0} input.json"
  exit
end

lyrics_syllables = JSON::load(File.read(ARGV[0]))

lyrics_syllables.each do |ls|
  print "<span data-dur=\"#{ls['duration']}\" data-begin=\"#{ls['start']}\""
  print " data-begintwo=\"#{ls['start2']}\"" unless ls['start2'].nil?
  print ">#{ls['text'].gsub("\n", "<br />").gsub("\r", "<br />")}</span>"
end
