require "rubygems"
require "json"

if ARGV[0].nil?
  puts "usage #{$0} input.json"
  exit
end

lyrics_syllables = JSON::load(File.read(ARGV[0]))

lyrics_syllables.each do |ls|
  if ls['duration'] > 0.0
    print "<span data-dur=\"#{ls['duration']}\" data-begin=\"#{ls['start']}\""
    print " data-begintwo=\"#{ls['start2']}\"" unless ls['start2'].nil?
    print ">"
  end
  print "#{ls['text'].gsub("\n", "<br />").gsub("\r", "<br />")}"
  if ls['duration'] > 0.0
    print "</span>"
  end
end
