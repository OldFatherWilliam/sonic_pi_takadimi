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
compoundmeter = (ring :Du, :du, :Va, :va, :Ki, :ki, :De, :de, :Da, :da, :Ma, :ma)

#Feel
Swing = 0.05

#player routine
unstressmeter = [:ta, :ka, :di, :mi, :va, :ki, :di, :da, :ma]
define :groove_player do |tB, instrument|
  sync tB
  case
  when tB == :shh then emphasis = 0
  when (unstressmeter.include? tB) then emphasis = 0.75
  else emphasis = 1.5
  end
  sample instrument, amp: emphasis * rrand(1-Swing, 1+ Swing)
  print tB, emphasis
end


#metronome
live_loop :shh do
  with_bpm Tempo[:allegro] do
    4.times do
      cue simplemeter.tick #Stress
      cue simplemeter.tick #Weak
      sleep B/4 * rrand(1-Swing, 1+ Swing)
    end
  end
end

live_loop :waltztime do
  sync_bpm :shh
  6.times do
    cue compoundmeter.tick #Stress
    cue compoundmeter.tick #Weak
    sleep B/6 * rrand(1-Swing, 1+ Swing)
  end
end

#groove library

march = (ring :Ta, :ta, :Ta, :ta)
squarewaltzshh = (ring :Ta, :ka, :Di, :mi, :Du, :va, :ki, :De, :da, :ma, :shh, :shh )
testshh = (ring :shh, :ta, :shh, :di, :da)
impeachKick = (ring :Ta, :shh, :shh, :shh, :Di, :Ta, :shh, :shh, :ta)
impeachSnare = (ring :shh, :shh, :Ta, :shh)
impeachClosedHH = (ring :Ta, :ta, :Ta, :ta, :Di, :ta, :shh, :Ta, :ta)
impeachOpenHH = (ring :shh,:shh,:shh,:shh,:shh,:Ta,:shh,:shh)


#drumkit
live_loop :Track01 do
  tB = impeachKick.tick
  instrument = :drum_bass_soft
  groove_player tB, instrument
end

live_loop :Track02 do
  tB = impeachSnare.tick
  instrument = :drum_snare_hard
  groove_player tB, instrument
end
live_loop :Track03 do
  tB = impeachClosedHH.tick
  instrument = :drum_cymbal_closed
  groove_player tB, instrument
end
live_loop :Track04 do
  tB = impeachOpenHH.tick
  instrument = :drum_cymbal_open
  groove_player tB, instrument
end

