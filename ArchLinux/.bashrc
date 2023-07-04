#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

# disable ctrl-s
stty -ixon


# set virtualenv prompt
function __virtualenv_ps1 {
    echo "${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}"
}

# get git branch
get_git_branch() {
    git branch |& awk '/^\*/ {print "("$2")"}'
}

# get terminal size
get_terminal_size(){
    echo "[$(tput cols)x$(tput lines)]"
}

alias bt='cat /sys/class/power_supply/BAT0/capacity'

# battery health
get_battery_percent(){
  bp=`bt`

  if [ $(bt) -gt 10 ]
  then 
    echo "($bp%)"
  else
    python -c "print('\033[01;31m($bp%)')" 
  fi
}

formated_path(){
    echo '$1' | python -c "import subprocess; a=input(); b = int(subprocess.getoutput('tput cols')); a = a[:b] + '| ' + a[b:] if a.find('\n')<b else a; print(a)"
}
 
# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]┌──\[\033[01;34m\]$(__virtualenv_ps1)\[\033[01;32m\][\u@\h\[\033[01;34m\]$(get_battery_percent)\[\033[01;32m\]] \[\033[01;34m\]\w\[\033[01;32m\]$(get_git_branch)\n\[\033[01;32m\]└─\$\[\033[00m\] '
# export PS1=formated_path $PS1

# aliases

alias a='alias'
a g=gedit
a ls='ls --color=auto'
a ll='ls -alF'
a la='ls -A'
a l='ls -CF'
a c='clear'
a sd='shutdown now'
a sps='sudo pacman -Sy'
a spr='sudo pacman -Rns'
a src='source ~/.bashrc'
a sai='sudo apt install '
a upd='sudo apt update && sudo apt -y upgrade'
a vb='vim ~/.bashrc'
a vv='vim ~/.vimrc'
a vx='vim ~/.xinitrc'
a vz='vim ~/.zshrc'
#a vf='vim ~/.fluxbox'
a v='vim'
a sv='sudo vim'
a rb='reboot'
a cte='crontab -e'
a ctl='crontab -l'
a scs='systemctl status'
a sce='sudo systemctl enable'
a scd='sudo systemctl disable'
a sc='sudo systemctl'
a mtm='sudo mount /dev/nvme0n1p4 /mnt/MyDrive'
a mtu='sudo mount /dev/nvme0n1p7 /mnt/Ubuntu20.04'
a btc='bluetoothctl'
a btcon='bluetoothctl connect 41:42:16:E8:F3:2B'
a fx='firefox'
a s='screen'
a p='python'


# that cannot be aliased becomes a function
lg(){
    search=`echo $@ | sed "s/ /+/g"`
    lynx "https://www.google.com/search?q=$search"
}

wg(){
    search=`echo $@ | sed "s/ /+/g"`
    w3m "https://www.google.com/search?q=$search"
}


# make st transparent
if [[ $TERM =~ ^st && ! -n $SSH_CLIENT ]]
then
    transset-df -a 0.7 > /dev/null
fi

# Add path to my scripts
PATH=$PATH:/home/abhinav/Abhinav/Programming/Bash/Scripts

# Add path to python scripts
PATH=$PATH:/home/abhinav/.local/bin


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Bash Plugins and handy options
if [ -f  /usr/share/blesh/ble.sh ]; then
    source /usr/share/blesh/ble.sh
fi
shopt -s autocd

# bind keys
bind '"\e[1;5A": history-search-backward'
bind '"\e[1;5B": history-search-forward'


