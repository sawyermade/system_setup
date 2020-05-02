# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Creates local bin, adds to path
if [ ! -d "$HOME/.local/bin" ]
then
	mkdir -p "$HOME/.local/bin" > /dev/null
fi
export PATH="$HOME/.local/bin:$PATH"

if [ ! -d "$HOME/AppImage" ]
then
	mkdir "$HOME/AppImage"
	chmod -R 755 "$HOME/AppImage"
fi
export PATH="$HOME/AppImage:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"
#ZSH_THEME="simple"
#ZSH_THEME="blinks"

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
plugins=(git conda-zsh-completion z tmux debian rsync)

source $ZSH/oh-my-zsh.sh

# User configuration
zstyle ':completion::complete:*' use-cache 1
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

### ALIAS ###
alias lsl='ls -lh'
alias aar='sudo apt autoremove -y'
alias adga='adg -y && aar'
alias rstart='screen -dmS rtorrent rtorrent'
alias rt='stty stop undef; stty start undef; screen -x rtorrent'
alias tsd='tmux new-session -d -s'
alias aii='$HOME/.aii.sh'
alias vu='globalprotect connect'
alias vd='globalprotect disconnect'
alias vs='globalprotect show --status'
### ALIAS ###

### CONDA ###
if [ -f ~/anaconda3/etc/profile.d/conda.sh ]
then
	source ~/anaconda3/etc/profile.d/conda.sh
	
elif [ -f /data/datasets/anaconda3/etc/profile.d/conda.sh ]
then 
	source /data/datasets/anaconda3/etc/profile.d/conda.sh
fi
# source /data/datasets/anaconda3/etc/profile.d/conda.sh > /dev/null 2>&1 || source ~/anaconda3/etc/profile.d/conda.sh > /dev/null 2>&1
### CONDA ###

### SSH ###
alias sshpf='eval $(ssh-agent) && ssh-add'
alias home1='ssh home1'
alias home2='ssh home2'
alias home1l='ssh home1l'
alias home2l='ssh home2l'
alias seedbox='ssh seedbox'
alias deepv='ssh deepv'
alias gaivi='ssh gaivi'
alias gaivi2='ssh gaivi2'
alias carrt='ssh carrt'
alias puppy='ssh puppy'
alias beast='ssh beast'
### SSH ###

### ROS ###
if [ -f /opt/ros/melodic/setup.zsh ]
then
	source /opt/ros/melodic/setup.zsh
fi
### ROS ###

### CUDA ###
# export PATH=/usr/local/cuda/bin:/usr/local/cuda/NsightCompute-2019.1${PATH:+:${PATH}}
# export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
### CUDA ###

### Conda Completion ###
autoload -U compinit && compinit
alias py='python3'
### Conda Completion ###

