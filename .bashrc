# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\](\u@\h\[\033[00m\]) - \[\033[01;34m\][\w]\[\033[00m\]\n\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]┌──[\u@\h] \[\033[01;34m\]\w\n\[\033[01;32m\]└─\$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export JAVA_HOME=/opt/jdk-17.0.2+8
PATH=$PATH:/home/abhinav/Abhinav/AppsUbuntu/Applications/cling_2020-11-05_ROOT-ubuntu2004/bin:/home/abhinav/Abhinav/AppsUbuntu/Applications/metasploit-framework:~/.scripts:$JAVA_HOME/bin


# Aliases
alias android-studio="/opt/android-studio/bin/studio.sh"
alias ue4editor="/home/abhinav/Abhinav/Programming/Unreal/Source/Linux/UnrealEngine/Engine/Binaries/Linux/UE4Editor"
. "$HOME/.cargo/env"


# disable ctrl-s
stty -ixon
[ -f "/home/abhinav/.ghcup/env" ] && source "/home/abhinav/.ghcup/env" # ghcup-env


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

formated_path(){
	echo '$1' | python -c "import subprocess; a=input(); b = int(subprocess.getoutput('tput cols')); a = a[:b] + '| ' + a[b:] if a.find('\n')<b else a; print(a)"
}

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]┌──\[\033[01;34m\]$(__virtualenv_ps1)\[\033[01;32m\][\u@\h] \[\033[01;34m\]\w\[\033[01;32m\]$(get_git_branch)\n\[\033[01;32m\]└─\$\[\033[00m\] '
# export PS1=formated_path $PS1

alias g=gedit

alias a='alias'
a c='clear'
a py='python'
a py2='python2'
a riscemu='python -m riscemu'
a sd='shutdown now'
a saa='sudo apt autoremove'
a ar='sudo apt remove '
a src='source ~/.bashrc'
a sai='sudo apt install '
a sad='sudo apt dist-upgrade'
a sau='sudo apt update && sudo apt -y upgrade'
a vb='vim ~/.bashrc'
a vv='vim ~/.vimrc'
a vg='sudo vim /etc/default/grub'
a v='vim'
a rb='reboot'
a cte='crontab -e'
a ctl='crontab -l'
a scs='systemctl status'
a sce='sudo systemctl enable'
a sc='sudo systemctl'
a mtm='sudo mkdir /media/abhinav/MyDrive && sudo mount /dev/nvme0n1p4 /media/abhinav/MyDrive'
a mta='sudo mkdir -p /media/abhinav/ArchLinux && sudo mount /dev/nvme0n1p8 /media/abhinav/ArchLinux'
a umm='sudo umount /dev/nvme0n1p4 && sudo rmdir /media/abhinav/MyDrive'
a uma='sudo umount /dev/nvme0n1p8 && sudo rmdir /media/abhinav/ArchLinux'
a rsc='~/Applications/Ripes-v2.2.5-2-geb801ef-linux-x86_64.AppImage --mode cli -t asm --proc RV64_SS --regs --src'
a pg='ps aux | grep'
a s='screen'
a bdsm='ssh azureuser@20.193.230.163'
a xv6='cd ~/Abhinav/AppsUbuntu/Applications/xv6 && make qemu-nox'


names=('harsh' 'maharshi' 'vedant' 'rajiv' 'raju')

eval "$(echo "orig_command_not_found_handle()"; declare -f command_not_found_handle | tail -n +2)"

function command_not_found_handle(){
    if [[ " ${names[*]} " = *" $1 "* ]]; then
        echo "$1 saala!"
    else
        orig_command_not_found_handle $@
    fi
}

function abhinav(){
    ascii-image-converter ~/Downloads/Images/Me.jpeg -C
    figlet Abhinav
}

function int() {
    echo "kaam pe dhyan de. Idhar udhar ki sochna band kar!!"
}

function hotspot() {
    nmcli connection up Hotspot
}

function vs(){
    echo    

}


# Bash Plugins and handy options
if [ -f ~/.local/share/blesh/ble.sh ]; then
    source ~/.local/share/blesh/ble.sh
fi
# bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'
shopt -s autocd

# bind keys
bind '"\e[1;5A": history-search-backward'
bind '"\e[1;5B": history-search-forward'

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# RISC-V path
export PATH=$PATH:/opt/riscv/bin

#RET-DEC path, The retargetable decompiler
export PATH=$PATH:/home/abhinav/Abhinav/AppsUbuntu/Applications/retdec/bin

# PATH to pico sdk
export PICO_SDK_PATH=/home/abhinav/Abhinav/Programming/Robotics/Pico/pico-sdk

# PATH to useful puthon scripts
export PATH=$PATH:/home/abhinav/Python/Scripts

#PATH to apps
export PATH=$PATH:/home/abhinav/Applications/Ripes-v2.2.5-2-geb801ef-linux-x86_64.AppImage

# Initialize Codex CLI
if [ -f "$HOME/.codexclirc" ]; then
    . "$HOME/.codexclirc"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# path to user script installs through pip
export PATH=$PATH:/home/abhinav/.local/bin

# path to wabt binaries
export PATH=$PATH:/home/abhinav/Abhinav/AppsUbuntu/Applications/wabt/bin


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/mnt/MyDrive/Abhinav/AppsUbuntu/google-cloud-sdk/path.bash.inc' ]; then . '/mnt/MyDrive/Abhinav/AppsUbuntu/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/mnt/MyDrive/Abhinav/AppsUbuntu/google-cloud-sdk/completion.bash.inc' ]; then . '/mnt/MyDrive/Abhinav/AppsUbuntu/google-cloud-sdk/completion.bash.inc'; fi
