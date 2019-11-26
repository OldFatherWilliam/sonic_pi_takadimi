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
  emphasis = 1.0
  gNote = gRing.tick
  case  gNote
  when :shh then
    sync :shh
    break
  when :O then # O is drum tab notation for accent
    emphasis = 1.5
    gNote = gRing.tick
    sync gNote
  when :g then # O is drum tab notation for ghost note
    emphasis = 0.15
    gNote = gRing.tick
    sync gNote
  when :f then # O is drum tab notation for flam
    emphasis = 0.15
    gNote = gRing.tick
    sync gNote
    sample instrument, amp: emphasis
    sleep beat_value*0.0625
    emphasis = 1.0
  when :d then # O is drum tab notation for drag
    emphasis = 0.15
    gNote = gRing.tick
    sync gNote
    2.times do
      sample instrument, amp: emphasis
      sleep beat_value*0.03125
    end
    emphasis = 1.0
  when :b then # O is drum tab notation for soft roll
    emphasis = 0.25
    gNote = gRing.tick
    sync gNote
    3.times do
      sample instrument, amp: emphasis
      sleep beat_value*0.03125
    end
    emphasis = 1.0
  when :B then # O is drum tab notation for hard roll
    emphasis = 0.75
    gNote = gRing.tick
    sync gNote
    2.times do
      sample instrument, amp: emphasis
      sleep beat_value*0.03
      emphasis = 1.25
      sample instrument, amp: emphasis
      sleep beat_value*0.05
      emphasis = 0.75
    end
  else sync gNote
  end
  sample instrument, amp: emphasis
  # print gNote, instrument, emphasis
end

#groove library
backbeat = (ring :ta, :O, :ta, :g, :ta, :f, :ta, :d, :ta, :b, :ta, :B, :ta)
poly2on3 = (ring :ta, :ki, :di, :da)

live_loop :Track01 do
  instrument = :drum_snare_soft
  gRing = backbeat
  groove_player gRing , instrument
end
