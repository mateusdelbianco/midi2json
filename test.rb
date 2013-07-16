require "rubygems"
require "midilib"
require "ostruct"
require "json"

class LyricSyllable < OpenStruct
  def as_json
    {
      "start" => self.seq.pulses_to_seconds(self.start.to_f).round(3),
      "duration" => self.seq.pulses_to_seconds(self.duration.to_f).round(3),
      "text" => self.text
    }
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


lyrics_track = MIDI::Track.new(seq)
noteon_track = MIDI::Track.new(seq)
seq.tracks[1].each do | event |
  if event.kind_of?(MIDI::MetaEvent) && event.meta_type == MIDI::META_LYRIC
    text = event.data.collect{|x| x.chr(Encoding::UTF_8)}.join
    if text.gsub(" ", "") != ""
      lyrics_track.events << event
    end
  end
  if event.kind_of?(MIDI::NoteOn)
    noteon_track.events << event
  end
end

durations = {}
noteon_track.each do |event|
  durations[event.time_from_start] = event.off.time_from_start - event.time_from_start
end


while lyrics_track.events.first.data.collect{|x| x.chr(Encoding::UTF_8)}.join.strip == ""
  lyrics_track.events.shift
end

lyrics_syllables = []
lyrics_track.each do |event|
  lyrics_syllables << LyricSyllable.new(
    :seq => seq,
    :start => event.time_from_start,
    :duration => durations[event.time_from_start],
    :text => event.data.collect{|x| x.chr(Encoding::UTF_8)}.join,
  )
end

puts lyrics_syllables.collect(&:as_json).to_json
