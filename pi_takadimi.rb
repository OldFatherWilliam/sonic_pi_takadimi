# Time Concepts

Tempo= {:grave =>45,
        :ballad => 60,
        :adagio => 66,
        :dub => 75,
        :andante => 78,
        :marcia =>84,
        :triphop => 93,
        :hiphop => 100,
        :pop => 108,
        :modereto => 112,
        :house => 120,
        :allegro => 128,
        :UKGarage => 130,
        :acid => 135,
        :dubstep => 140,
        :grime => 145,
        :footwork => 160,
        :dnb => 175}

#B =2.0 #same as /2 time
B = 1.0  # same as /4 time
#B = 0.5  # same as /8 time

#meter rings (Capital is stress)
simplemeter = (ring :Ta, :ta, :Ka, :ka, :Di, :di, :Mi, :mi)
compoundmeter = (ring :Du, :du, :Va, :va, :Ki, :ki, :Di, :di, :Da, :da, :Ma, :ma)

#Feel
Swing = 0.01

#kludges
unstressmeter = [:ta, :ka, :di, :mi, :va, :ki, :di, :da, :ma]

#metronome
live_loop :shh do
  with_bpm Tempo[:ballad] do
    cue simplemeter.tick #Stress
    cue simplemeter.tick #Weak
    sleep B/4
  end
end

live_loop :waltz do
  sync_bpm :shh
  with_bpm Tempo[:dubstep] do
    cue compoundmeter.tick #Stress
    cue compoundmeter.tick #Weak
    sleep B/6
  end
end

#score
clavebell = (ring :Ta, :Da, :Di, :Da, :Di, :Ta, :Da)

#drumkit
groove = clavebell
live_loop :Track01 do
  tB = groove.tick
  sync tB
  sleep rand(Swing)
  case
  when tB == :shh then emphasis = 0
  when (unstressmeter.include? tB) then emphasis = 0.75
  else emphasis = 1.5
  end
  sample :drum_cymbal_closed, amp: emphasis * rrand(1-Swing, 1+ Swing)
  print tB, emphasis
end
