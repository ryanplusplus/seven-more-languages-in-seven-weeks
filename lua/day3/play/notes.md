# Fedora 23
## Install
```shell
sudo dnf install timidity++ lua-devel rtmidi-devel cmake
```

## Build
```shell
cmake . && make
```

## Run
Start a MIDI device in another terminal using `timidity`:
```shell
timidity -iA
```

Actually run it:
```shell
./play <song>.lua
```
