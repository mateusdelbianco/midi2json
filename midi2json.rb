require "rubygems"
require "bundler/setup"
Bundler.require

if ARGV[0].nil?
  puts "usage #{$0} input.mid"
  exit
end

puts MidiLyrics::Parser.new(ARGV[0]).extract.to_json
