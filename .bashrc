# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias pplxint6='ssh pplxint6.physics.ox.ac.uk -l brisbane '
alias pplxint8='ssh pplxint8.physics.ox.ac.uk -l brisbane '
alias setup-tunnel='ssh -fN -L 2225:163.1.246.45:22  brisbane@pplxint6.physics.ox.ac.uk'
alias termserv='rdesktop -g workarea termserv.physics.ox.ac.uk -u brisbane -d PHYSICS'
alias windowsdesktop='rdesktop -g workarea termserv.physics.ox.ac.uk -u brisbane -d PHYSICS '
alias pplxint6='ssh brisbane@pplxint6.physics.ox.ac.uk -X'
export PATH=$PATH:/home/brisbanel/bin
alias termservadmin='rdesktop -g workarea termservla.physics.ox.ac.uk -u brisbanesu -d PHYSICS'
alias linuxts='ssh  -NL 13389:linuxts.physics.ox.ac.uk:3389 brisbane@pplxint6.physics.ox.ac.uk&& ssh  -NL 3350:linuxts.physics.ox.ac.uk:3350 brisbane@pplxint6.physics.ox.ac.uk;rdesktop -g workarea localhost:13389.physics.ox.ac.uk -u brisbanesu -d PHYSICS'
eval $(keychain --eval --agents ssh -Q --quiet MyKey3)
if ! ssh-add -L | grep MyKey3 >/dev/null 2>&1; then
   ssh-add ~/.ssh/MyKey3 > /tmp/log && git fetch && git pull && touch $HOME/.lastgitpull 
else
 
[ $(( `date +%s` - 3600 )) -lt $(stat --printf=%Y $HOME/.lastgitpull) ] || ( git fetch && git pull  && touch $HOME/.lastgitpull )
fi

SSH_ASKPASS=""
HISTFILESIZE=4000000
HISTSIZE=10000
PROMPT_COMMAND="history -a"
export HISTSIZE PROMPT_COMMAND
shopt -s histappend
declare 	-x AWS_ACCESS_KEY_ID="$( cat $HOME/.ssh/amazon-root-key.id )"
declare 	-x AWS_ACCESS_KEY="$( cat $HOME/.ssh/amazon-root-key.id )"
declare 	-x AWS_SECRET_ACCESS_KEY="$( cat $HOME/.ssh/amazon-root-key.key )"
declare 	-x AWS_SECRET_KEY="$( cat $HOME/.ssh/amazon-root-key.key )"
test -d /local${HOME}/.thunderbird || mkdir -p /local${HOME}/.thunderbird
export DEBFULLNAME="Sean Brisbane"
export DEBEMAIL="s.brisbane1@physics.ox.ac.uk"
export UBUNTUTOOLS_UBUNTU_MIRROR=http://archive.ubuntu.com/ubuntu
alias buildppa='debuild -S -sa -k795191C7 && dput ppa:s-brisbane1/oxford-physics'
alias uploadppa='dput ppa:s-brisbane1/oxford-physics '
alias deploybzr='ssh root@cplxconfig1.physics.ox.ac.uk /usr/local/bin/checkout_masterfiles.sh'
alias kinitb='kinit brisbane@PHYSICS.OX.AC.UK'
