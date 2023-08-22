# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

DISABLE_AUTO_UPDATE=true

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="sorin"

#Ignore for root
ZSH_DISABLE_COMPFIX=true

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	fzf
)
#plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export EDITOR='nvim'

# User configuration

#aliases
alias ls='ls --color=auto'
alias lss='ls --sort=size'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias :q='exit'
alias :wq='exit'
alias sl='ls'
alias update='paru -Suy --skipreview --upgrademenu'
alias гвзфеу='update'
alias install='sudo pacman -S'
alias proton="/home/$USER/.other/proton.sh"
alias watch2="/home/$USER/.other/watch2.sh"
alias i3edit='vim ~/.config/i3/config'
alias viedit='nvim ~/.config/nvim/init.vim'
alias vim='nvim'
alias v='vim'
alias svim='doasedit'
alias neofetch='neofetch --backend kitty --source ~/.config/neofetch/arch.png'

#Style the man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;36m'

#Autosuggestions
bindkey '^N'      autosuggest-accept
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'

#Use LSD
command -v lsd &> /dev/null && alias ls='lsd -l --icon never --group-dirs first'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
     --color=fg:#CCCCCC,bg:#1e222a,hl:#ffcb6b
     --color=fg+:#62de84,bg+:#292d3e,hl+:#ffcb6b
     --color=info:#959dcb,prompt:#62DE84,pointer:#62de84
     --color=marker:#ff5572,spinner:#f07178,header:#1D918B'

PATH="/home/$USER/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/$USER/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/$USER/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/$USER/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/$USER/perl5"; export PERL_MM_OPT;
export TERM=alacritty


export PATH=/opt/rocm/bin:$PATH
export HSA_OVERRIDE_GFX_VERSION=10.3.0 HCC_AMDGPU_TARGET=gfx1030

export VISUAL="nvim"
