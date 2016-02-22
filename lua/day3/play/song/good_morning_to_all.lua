local scheduler = require 'scheduler'
local notation = require 'notation'

local notes = {
  'D4q',
  'E4q',
  'D4q',
  'G4q',
  'Fs4h'
}

local function play_song()
  for i = 1, #notes do
    notation.play(notes[i])
  end
end

scheduler.schedule(0.0, coroutine.create(play_song))
scheduler.run()
