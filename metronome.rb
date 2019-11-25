# Configuration
Time_signature = [5,4.0] #2nd number has to be a float
Tempo = 60
Swing = 0.0 #less is more, friends

#prepartory calculations
Bar = 0
beats_per_bar = Time_signature[0]
beat_value = (1/Time_signature[1])*4
rhythmaning = (ring [:ta, 0.167],[:va, 0.083],[:ka, 0.083],[:ki, 0.167],[:di, 0.167],[:da, 0.083],[:mi, 0.083],[:ma, 0.167])

#metronome

define :ssleep do |rest_duration|
  sleep rest_duration * rrand(1-Swing, 1+ Swing)
end

live_loop :shh do #shh means rest until the start of the next bar
  Bar += 1
  #print Bar
  
  
  with_bpm Tempo do
    beats_per_bar.times do
      8.times do
        tB = rhythmaning.tick
        #print tB[0]
        cue tB[0]
        ssleep tB[1] * beat_value
        
      end
    end
  end
end

#groove player
define :groove_player do |gRing, instrument|
  gNote = gRing.tick
  case  gNote
  when :shh then
    sync :shh
    break
  when :O then
    emphasis = 1.5
    gNote = gRing.tick
  else emphasis = 1.0
  end
  
  sync gNote
  
  sample instrument, amp: emphasis
  # print gNote, instrument, emphasis
end

#groove library
backbeat = (ring :ta, :O, :ta, :ta, :O, :ta)
poly2on3 = (ring :ta, :ki, :di, :da)

live_loop :Track01 do
  instrument = :drum_bass_hard
  gRing = backbeat
  groove_player gRing , instrument
end
