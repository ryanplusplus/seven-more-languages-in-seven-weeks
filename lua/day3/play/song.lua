local scheduler = require 'scheduler'

local function note(letter, octave)
  local notes = {
    C = 0,
    Cs = 1,
    D = 2,
    Ds = 3,
    E = 4,
    F = 5,
    Fs = 6,
    G = 7,
    Gs = 8,
    A = 9,
    As = 10,
    B = 11
  }

  return (octave + 1) * 12 + notes[letter]
end

local tempo = 100

local function duration(value)
  local quarter = 60 / tempo
  local durations = {
    h = 2.0,
    q = 1.0,
    ed = 0.75,
    e = 0.5,
    s = 0.25
  }

  return durations[value] * quarter
end

local function parse(s)
  local letter, octave, value = s:match('([A-Gs]+)(%d+)(%a+)')

  if not (letter and octave and value) then
    return nil
  end

  return {
    note = note(letter, octave),
    duration = duration(value)
  }
end

local NOTE_DOWN = 0x90
local NOTE_UP = 0x80
local VELOCITY = 0x7F

local function play(s)
  local parsed = parse(s)

  midi_send(NOTE_DOWN, parsed.note, VELOCITY)
  scheduler.wait(parsed.duration)
  midi_send(NOTE_UP, parsed.note, VELOCITY)
end

local function part(t)
  scheduler.schedule(0.0, coroutine.create(function()
    for i = 1, #t do
      play(t[i])
    end
  end))
end

local function set_tempo(bpm)
  tempo = bpm
end

local function go()
  scheduler.run()
end

local mt = {
  __index = function(t, s)
    local result = s
    return result or rawget(t, s)
  end
}

setmetatable(_G, mt)

return {
  set_tempo = set_tempo,
  part = part,
  play = go
}
