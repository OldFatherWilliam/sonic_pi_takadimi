# Time Concepts

Tempo= {:grave =>45,
        :ballad => 60,
        :adagio => 66,
        :dub => 75,
        :andante => 78,
        :marcia =>84,
        :triphop => 93,
        :hiphop => 104,
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
B = 1.0# same as /4 time
#B = 0.5  # same as /8 time

songring = (ring 0,1,2,3,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,2,3,2,1,0,1,1,1,1,1,1,0)
songpart = songring.tick #initialization value


#meter rings (Capital is stress)
simplemeter = (ring :Ta, :ta, :Ka, :ka, :Di, :di, :Mi, :mi)
compoundmeter = (ring :Du, :du, :Va, :va, :Ki, :ki, :De, :de, :Da, :da, :Ma, :ma)

#Feel
Swing = 0.1001

#player routines
unstressmeter = [:ta, :ka, :di, :mi, :du, :va, :ki, :de, :da, :ma]
define :groove_player do |tB, instrument, bCustom|
  sync_bpm tB
  case
  when tB == :shh then break
  when (unstressmeter.include? tB) then emphasis = 0.75
  else emphasis = 1.5
  end
  if bCustom
    sample instrument[0], amp: instrument[1]* rrand(1-Swing, 1+ Swing), beat_stretch: B*instrument[2], start: instrument[3], finish: instrument[4]
    #sleep B*instrument[2]
  else
    sample instrument, amp: emphasis
  end
  print tB, emphasis
end


#metronome
live_loop :shh do
  with_bpm Tempo[:hiphop] do
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

#custom_samples
jtsnare = "C:/Users/wmli/Music/jtfb_sn1.wav"
load_sample jtsnare
jtkik = "C:/Users/wmli/Music/jtfb_kik.wav"
load_sample jtkik

jtpal = "C:/Users/wmli/Music/jtfb_pallette.wav"
load_sample jtpal


#groove library

dropitand7 = (ring :ta, :shh, :shh, :shh, :shh, :shh,:shh, :shh)
dropitonthe5 = (ring :shh, :shh, :shh, :shh, :shh, :Ta, :shh, :shh, :shh)
dropitand3 = (ring :di, :shh, :shh, :shh, :shh)
dumbring = (ring :shh, :shh, :ta, :shh, :shh, :shh, :Ta, :shh)
backbeat = (ring :Ta, :ta, :Ta, :Ta)
poly2on3 = (ring :Ta, :Ki, :Di, :Da)
march = (ring :Ta, :ta, :Ta, :ta)
squarewaltzshh = (ring :Ta, :ka, :Di, :mi, :Du, :va, :ki, :De, :da, :ma, :shh, :shh )
testshh = (ring :shh, :ta, :shh, :di, :da)
impeachKick = (ring :Ta, :shh, :shh, :shh, :Di, :Ta, :shh, :shh, :ta)
impeachSnare = (ring :shh, :shh, :Ta, :shh)
impeachClosedHH = (ring :Ta, :ta, :Ta, :ta, :Di, :ta, :shh, :Ta, :ta)
impeachOpenHH = (ring :shh,:shh,:shh,:shh,:shh,:Ta,:shh,:shh)
tresillo = (ring :Ta, :Ki, :shh, :Da, :shh, :ta, :Di)
halfsilentdisco = (ring :ta, :ta, :Di, :shh, :shh, :De, :shh, :shh, :Va,:shh, :shh, :du,:shh, :shh, :Ka,:shh, :shh, :mi,:shh, :shh, :shh,:Ta)
take5 = (ring :Ta, :Di, :shh, :ta, :Ki, :mi, :shh, :shh, :Da)
sonClave = (ring :Ta, :shh, :mi, :shh, :Di, :shh, :Di, :shh, :Ta, :shh)
silentdisco = (ring :shh)
groove1 = (ring :Di, :Di, :Ta, :ka, :Di, :mi, :Ta, :di, :ka, :Di, :Ta, :shh, :Di, :mi, :Ta, :Di)
straight8ths = (ring :Ta, :Di)
trapHH = (ring :Ta,  :shh, :di,  :shh, :di, :shh, :di, :di)
trapH1 = (ring :shh, :di, :shh ,:Ta, :du, :va, :ki, :shh, :du, :va, :ki, :ta)
trapkick = (ring :Ta, :shh, :shh, :shh, :di, :ta, :shh, :di, :ta)
#drumkit


live_loop :Track01 do
  
  case
  when songpart==0 then
    #introHH
    instrument = [jtpal, 1,10, 0.333, 0.0]
    tB = dropitand7.tick
    groove_player tB, instrument, true
    
    
    
  when songpart>0 then
    tB = trapHH.tick
    instrument = [jtpal, 0.15,5, 0.333, 0.376]
    groove_player tB, instrument, true
    
  else
    sync_bpm :shh
  end
  
end


live_loop :Track02 do
  case
  
  when songpart>0 then
    
    instrument = [jtpal, 0.35,20, 0.416, 0.45]
    tB = trapH1.tick
    groove_player tB, instrument, true
    
    
  else
    sync_bpm :shh
  end
  6
end

live_loop :Track03 do
  case
  when songpart>1 then
    
    #KicknSlap
    instrument = [jtpal, 0.2,40, 0.75, 0.81]
    tB = trapkick.tick
    groove_player tB, instrument, true
    
    
  else
    sync_bpm :shh
  end
  
end

live_loop :Track04 do
  case
  when songpart>2 then
    
    #PickupSnare
    #instrument = [jtpal, 1,10, 0.75, 0.8329]
    instrument = :drum_snare_soft
    tB = dumbring.tick
    groove_player tB, instrument, false
    
    
  else
    sync_bpm :shh
  end
  
end

live_loop :Track05 do
  case
  when songpart>3 then
    
    #PickupSnare
    instrument = [jtpal, 0.5,30, 0.66, 0.76]
    tB = backbeat.tick
    groove_player tB, instrument, true
    
    
  else
    sync_bpm :shh
  end
  
end


live_loop :Track06 do
  case
  when songpart>4 then
    
    #PickupSnare
    instrument = [jtpal, 1,10, 0.75, 0.8329]
    #instrument = :drum_snare_soft
    tB = dumbring.tick
    groove_player tB, instrument, true
    
    
  else
    sync_bpm :shh
  end
  
end


loop do
  16.times do
    sync :shh
  end
  
  songpart = songring.tick
end
