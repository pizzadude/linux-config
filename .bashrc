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
HISTSIZE=1000
HISTFILESIZE=2000

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

#    _               _              
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
#

#trash-cli
#alias rm='echo "This is not the command you are looking for. Use trash-put instead."; false'

# yt script
#alias yt='~/bin/yt'

# for laptop only
alias touchpad-on='xinput set-int-prop 11 "Device Enabled" 8 1'

# zsnes fix
#alias zsnes='/usr/local/bin/zsnes.sh'

# cinnamon quit
#alias logout='cinnamon-session-quit --logout --no-prompt'

#alias youtube-dl='python /home/pizzadude/bin/youtube-dl'
alias clipboardclear='xsel -bc'
alias reviews='python /home/pizzadude/Documents/scripts/reviews.py'
alias chocolate-doom='chocolate-doom -novert'
#alias rott='cd ~/Games/rott && ./rott'
alias scrotwindow='sleep 5s && scrot -s'

upl-imgur() { 
	curl -# -F image=@"$1" -F "key=1913b4ac473c692372d108209958fd15" \
	http://api.imgur.com/2/upload.xml | grep -Eo "<original>(.)*</original>" \
	| grep -Eo "http://i.imgur.com/[^<]*"
}

alias lst='ls -l'
alias lsta='ls -la'


extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

alias pastebinit='pastebinit -a "user" -b "http://slexy.org"' 
alias pbcopy='xclip -selection clipboard'	# copy to clipboard, ctrl+c, ctrl+shift+c
alias pbpaste='xclip -selection clipboard -o'	# paste from clipboard, ctrl+v, ctrl+shitt+v
alias pbselect='xclip -selection primary -o'	# paste from highlight, middle click, shift+insert
alias pbdump='pbpaste | pastebinit | pbcopy'	# dump text to pastebin server

alias syslog='cat /var/log/syslog'
alias authlog='cat /var/log/auth.log'

#archey
#archey

#alias mcl='java -jar ~/Downloads/Minecraft/minecraft.jar'
alias psr='ps aux | grep root'
alias brc='cat ~/.bashrc'
#alias desmume='desmume --cpu-mode=1'
alias ip='curl icanhazip.com'

#fix bluetooth
alias fixbt='sudo chmod +x /usr/sbin/bluetoothd && sudo service bluetooth restart'
alias darkplaces='darkplaces -basedir /usr/games/quake'
alias manga_downloader='python ~/src/manga_downloader/src/manga.py -d ~/Manga/ $1'

alias castnow='castnow --address=192.168.1.8 --myip 192.168.1.9 $1'
alias castnowmp4='castnow --address=192.168.1.8 --myip 192.168.1.9 --tomp4 $1'

#. /etc/profile.d/vte-2.91.sh
#source /etc/profile.d/vte.sh

if [ $TERMINIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi


#-------- FreeTuxTV - Free IPTV Using Existing Database {{{
#------------------------------------------------------
# DEMO: https://www.youtube.com/watch?v=ZTLIGP98zpk
# DESC: free iptv working list from freetuxtv webtv database
# REFF: http://database.freetuxtv.net/site/index
#       How to use nvlc: https://www.youtube.com/watch?v=7y_58wpHuFE

alias nvlc='nvlc --no-color'                # vlc black/white color
freetuxtv-nolang() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=none&isp=all" ;}
freetuxtv-french() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=fr&isp=all" ;}
freetuxtv-english() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=en&isp=all" ;}
freetuxtv-turkish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=tr&isp=all" ;}
freetuxtv-spanish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=es&isp=all" ;}
freetuxtv-german() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=de&isp=all" ;}
freetuxtv-arabic() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ar&isp=all" ;}
freetuxtv-italian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=it&isp=all" ;}
freetuxtv-russian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ru&isp=all" ;}
freetuxtv-chinese() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=zh&isp=all" ;}
freetuxtv-slovak() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=sk&isp=all" ;}
freetuxtv-czech() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=cs&isp=all" ;}
freetuxtv-hungerian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=hu&isp=all" ;}
freetuxtv-portuguese() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=pt&isp=all" ;}
freetuxtv-bulgarian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=bg&isp=all" ;}
freetuxtv-romanian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ro&isp=all" ;}
freetuxtv-serbo-croatian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=sh&isp=all" ;}
freetuxtv-serbian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=sr&isp=all" ;}
freetuxtv-dutch() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=nl&isp=all" ;}
freetuxtv-croatian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=hr&isp=all" ;}
freetuxtv-persian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=fa&isp=all" ;}
freetuxtv-polish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=pl&isp=all" ;}
freetuxtv-hindi() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=hi&isp=all" ;}
freetuxtv-albanian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=sq&isp=all" ;}
freetuxtv-macedonian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=mk&isp=all" ;}
freetuxtv-indonesian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=in&isp=all" ;}
freetuxtv-greek() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=el&isp=all" ;}
freetuxtv-korean() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ko&isp=all" ;}
freetuxtv-hebrew() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=iw&isp=all" ;}
freetuxtv-ukrainian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=uk&isp=all" ;}
freetuxtv-vietnamese() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=vi&isp=all" ;}
freetuxtv-slovenian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=sl&isp=all" ;}
freetuxtv-thai() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=th&isp=all" ;}
freetuxtv-japanese() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ja&isp=all" ;}
freetuxtv-finnish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=fi&isp=all" ;}
freetuxtv-lithuanian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=lt&isp=all" ;}
freetuxtv-danish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=da&isp=all" ;}
freetuxtv-kurdish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ku&isp=all" ;}
freetuxtv-swedish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=sv&isp=all" ;}
freetuxtv-azerbaijani() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=az&isp=all" ;}
freetuxtv-amharic() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=am&isp=all" ;}
freetuxtv-malay() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ms&isp=all" ;}
freetuxtv-norwegian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=no&isp=all" ;}
freetuxtv-bengali-bangla() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=bn&isp=all" ;}
freetuxtv-armenian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=hy&isp=all" ;}
freetuxtv-georgian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ka&isp=all" ;}
freetuxtv-urdu() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ur&isp=all" ;}
freetuxtv-latin() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=la&isp=all" ;}
freetuxtv-catalan() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ca&isp=all" ;}
freetuxtv-tagalog() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=tl&isp=all" ;}
freetuxtv-estonian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=et&isp=all" ;}
freetuxtv-latvian-lettish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=lv&isp=all" ;}
freetuxtv-afrikaans() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=af&isp=all" ;}
freetuxtv-kazakh() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=kk&isp=all" ;}
freetuxtv-cambodian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=km&isp=all" ;}
# freetuxtv-malayalam() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ml&isp=all" ;}
freetuxtv-somali() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=so&isp=all" ;}
# freetuxtv-gujarati() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=gu&isp=all" ;}
freetuxtv-mongolian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=mn&isp=all" ;}
freetuxtv-maltese() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=mt&isp=all" ;}
freetuxtv-turkmen() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=tk&isp=all" ;}
freetuxtv-irish() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ga&isp=all" ;}
# freetuxtv-interlingua() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=ia&isp=all" ;}
freetuxtv-moldavian() { nvlc "http://database.freetuxtv.net/WebStreamExport/index?format=m3u&type=1&status=2&lng=mo&isp=all" ;}

# }}}

########################################################################
alias stream2chromecast='stream2chromecast -port 8765 -devicename 192.168.1.8'
PATH=$PATH:~/.local/bin:~/.luarocks/bin

alias batstat='cat /sys/class/power_supply/BAT0/capacity'
alias batinfo='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

alias vlcast='vlc --sout="#chromecast{ip=192.168.1.8}" --sout-chromecast-http-port 8009 $1'

#export PULSE_LATENCY_MSEC=60
alias rm='echo "rm is disabled."; false'
#function _update_ps1() {
#    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
#}

#if [ "$TERM" != "linux" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

alias hub='/home/pizzadude/bin/hub'
alias btfix='python3.5 /home/pizzadude/bin/bt-fix.py'

NPM_PACKAGES="${HOME}/.npm-packages"

PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

alias qbbl='~/bin/update-qbt-bl'

#alias cinnfix='export DISPLAY=:0.0 && cinnamon --replace'
alias newsbeuter='newsbeuter -C ~/.config/newsbeuter/newsbeuter.conf'
alias news='newsbeuter -C ~/.config/newsbeuter/newsbeuter.conf'
alias youtubemp3='youtube-dl -x --audio-format mp3 $1'
alias sudo='sudo '

export NPM_PACKAGES="/home/pizzadude/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

export GOPATH=/home/pizzadude/gocode/
export PATH=$PATH:$GOPATH/bin


alias gloc='~/gloc/gloc'
alias subextract='~/bin/subextract'


alias archey='screenfetch'
alias aria='aria2c -j 8 -k 2M -s 8 -x 8'

export MPD_HOST=$HOME/.mpd/socket

if [[ $TILIX_ID ]]; then
        source /etc/profile.d/vte.sh
fi
