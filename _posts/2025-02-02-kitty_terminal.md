---
layout: post
title: "kitty terminal emulator"
date:   2025-02-02 22:00:00 +0900
categories: terminal 
---

## kitty
[kitty](https://github.com/kovidgoyal/kitty) is cross-platform, fast terminal emulator. Users can customize the terminal in many ways easily with its text based configuration file. I'm using this because it can provide consistent terminal environment over multiple operating systems and has good documentation.

## Installation
According to [official guide](https://sw.kovidgoyal.net/kitty/build/), It requires some dependencies.

### Built-time dependencies
#### Common
- `gcc` or `clang`
- [go](https://go.dev/dl/)


#### Linux
```
apt-get install simde pkg-config libdbus-1-dev libxcursor-dev libxrandr-dev libxi-dev libxinerama-dev libgl1-mesa-dev libxkbcommon-x11-dev libfontconfig-dev libx11-xcb-dev liblcms2-dev libssl-dev libpython3-dev libxxhash-dev libsimde-dev
```
#### macOS
```
brew install simde pkg-config
```


### Run-time dependencies
#### Ubuntu
If `Python` (>= 3.8) does not exists in apt repository, install it manually.
```
apt-get install python harfbuzz zlib libpng liblcms2 libxxhash openssl freetype fontconfig libcanberra
```
#### macOS (10.14 or newer)
macOS has old version of system python. Use python version manager like pyenv to install and use newer version of python.
```
brew install python harfbuzz zlib libpng liblcms2 libxxhash openssl
```

### Build
```
./dev.sh build
```
There are other build options such as debug, sanitize. See the guide for the details.


## Configuration
Open configuration file with a command `Ctrl+Shift+F2` and reload it with `Ctrl+Shift+F5` after saving the file. Options can be tested with those commands easily.
### Keyboard shortcuts
`map {key combination} {action} {args...}`

#### Creation
```
# create vertical split window where shell's cwd is same as current window
map alt+d launch --location=vsplit --cwd=current

# create horizontal split window
map alt+shift+d launch --location=hsplit --cwd=current
```

#### Window traversal
```
map alt+k neighboring_window up
map alt+h neighboring_window left
map alt+l neighboring_window right
map alt+j neighboring_window down
```

#### Tab shortcut
```
map alt+1 goto_tab 1
map alt+2 goto_tab 2
```

### Fonts
User can make fonts look similar over multiple operating systems by adjusting font options
```
font_family      family='{font name}'

text_composition_strategy 1.0 0
font_size        13.0
modify_font      cell_width 95%
modify_font      cell_height 0px
```

### Tab bar
This example is for Vim-like tab bar
```
tab_bar_style separator
tab_title_template " {index}: {tab.active_exe} "
tab_separator " "
inactive_tab_foreground #000000
inactive_tab_background #707070
```
