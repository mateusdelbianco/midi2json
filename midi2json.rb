require "rubygems"
require "bundler/setup"
Bundler.require

if ARGV[0].nil?
  puts "usage #{$0} input.mid"
  exit
end

lyrics = MidiLyrics::Parser.new(ARGV[0]).extract

puts lyrics.collect(&:as_json).to_json
