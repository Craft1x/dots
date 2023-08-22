export QT_QPA_PLATFORMTHEME=qt6ct
export EDITOR=/usr/bin/vim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

export TERMINAL=/usr/bin/alacritty

PATH=$PATH:$HOME/.cargo/bin
PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin

# export GTK_THEME=Flat-Remix-Green
export GTK_THEME=Adwaita:dark

export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache

export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export KERAS_HOME="${XDG_STATE_HOME}/keras"
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
