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
./play song/<name>.lua
```

# Ubuntu 17.04
## Install
Install Lua via [lenv](https://github.com/mah0x211/lenv).

```shell
sudo apt install timidity librtmidi-dev cmake
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
./play song/<name>.lua
```
