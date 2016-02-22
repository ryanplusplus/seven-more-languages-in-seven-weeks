local NOTE_DOWN = 0x90
local NOTE_UP = 0x80
local VELOCITY = 0x7F

function play(note)
  midi_send(NOTE_DOWN, note, VELOCITY)
  while os.clock() < 1 do end
  midi_send(NOTE_UP, note, VELOCITY)
end

play(60)
