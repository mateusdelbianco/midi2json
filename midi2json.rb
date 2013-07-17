require "rubygems"
require "bundler/setup"
Bundler.require

if ARGV[0].nil?
  puts "usage #{$0} input.mid"
  exit
end

lyrics = MidiLyrics::Parser.new(ARGV[0]).extract

puts lyrics.collect{|x| { text: x.text, start: x.start, start2: x.start2, duration: x.duration } }.to_json
