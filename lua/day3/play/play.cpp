extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

#include "RtMidi.h"

static RtMidiOut midiForPortCount;
static RtMidiOut **midi;

static int midi_send(lua_State *L)
{
  double status = lua_tonumber(L, -4);
  double data1 = lua_tonumber(L, -3);
  double data2 = lua_tonumber(L, -2);
  double which = lua_tonumber(L, -1);

  std::vector<unsigned char> message(3);
  message[0] = static_cast<unsigned char>(status);
  message[1] = static_cast<unsigned char>(data1);
  message[2] = static_cast<unsigned char>(data2);

  (*midi[(unsigned)which]).sendMessage(&message);

  return 0;
}

static void play_song(lua_State *L, const char *filename)
{
  char script[1000];
  sprintf(
    script,
    "local song = require 'song'\n"
    "local chunk, err = loadfile('%s', 't', setmetatable({ song = song }, { __index = _G }))\n"
    "if not chunk then\n"
    "  print(err)\n"
    "  return\n"
    "end\n"
    "chunk()\n"
    "song.play()",
    filename);
  luaL_dostring(L, script);
}

int main(int argc, const char *argv[])
{
  if(argc < 2)
  {
    return -1;
  }

  unsigned ports = midiForPortCount.getPortCount();

  if(ports < 1)
  {
    return -1;
  }

  midi = (RtMidiOut **)calloc(ports, sizeof(RtMidiOut *));

  for(unsigned i = 0; i < ports; i++)
  {
    midi[i] = new RtMidiOut();
    (*midi[i]).openPort(i);
  }

  lua_State* L = luaL_newstate();
  luaL_openlibs(L);

  lua_pushcfunction(L, midi_send);
  lua_setglobal(L, "midi_send");

  play_song(L, argv[1]);

  lua_close(L);

  for(unsigned i = 0; i < ports; i++)
  {
    delete midi[i];
  }

  free(midi);

  return 0;
}
