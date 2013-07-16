require "rubygems"
require "midilib"
require "ostruct"
require "json"
require "debugger"

class LyricSyllable < OpenStruct
  def to_json
    {
      "start" => self.start,
      "duration" => self.duration,
      "text" => self.text
    }.to_json
  end
end

seq = MIDI::Sequence.new()

if ARGV[0].nil?
  puts "usage #{$0} input.mid"
  exit
end

# Read the contents of a MIDI file into the sequence.
File.open(ARGV[0], "rb") do | file |
  seq.read(file)
end

lyrics_syllables = []

seq.each do | track |
  track.each do | event |
    if event.kind_of?(MIDI::MetaEvent) && event.meta_type == MIDI::META_LYRIC
      text = event.data.collect{|x| x.chr(Encoding::UTF_8)}.join.strip
      if text != ""
        lyrics_syllables << LyricSyllable.new(
          :start => event.time_from_start,
          :duration => event.delta_time,
          :text => text,
        )
      end
    end
  end
end

print lyrics_syllables.collect(&:to_json).to_json