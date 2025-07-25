# Enabling some shell options
shopt -s autocd cdspell dirspell direxpand

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
HISTSIZE=9000
HISTFILESIZE=9000

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

GIT_PS1_DESCRIBE_STYLE='contains'
GIT_PS1_SHOWCOLORHINTS='y'
GIT_PS1_SHOWDIRTYSTATE='y'
GIT_PS1_SHOWSTASHSTATE='y'
GIT_PS1_SHOWUNTRACKEDFILES='y'
GIT_PS1_SHOWUPSTREAM='auto'

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1)\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
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

# custom commands
yazi() {
  local tmpfile=$(mktemp)
  command yazi "$@" --cwd-file="$tmpfile"
  if [ -f "$tmpfile" ]; then
    local dir=$(cat "$tmpfile")
    if [ -d "$dir" ]; then
      cd "$dir"
    fi
    rm -f "$tmpfile"
  fi
}

findInFileAndOpen()
{
  grep -ri $1 | nvim $(fzf --reverse | cut -d ":" -f1)
}

findAndReplaceInDir()
{
  find $3 -type f -exec sed -i "s/$1/$2/g" {} +
}

gitWorktreeAdd()
{
  branch=$(git branch --list --all | fzf --reverse --preview "git diff {1} --color=always | delta" | cut -d "/" -f3)
  mkdir -p "../$branch"
  git worktree add "../$branch" "$branch"
}

gcb() {
  git checkout $(git branch --list --all | fzf --reverse --preview "git diff {1} --color=always | delta"| cut -d "/" -f3)
}

gcf() {
  local selected=$(_fzf_git_files --no-multi)
  [ -n "$selected" ] && nvim "$selected"
}

gcc() {
  local selected=$(_fzf_git_hashes --no-multi)
  [ -n "$selected" ] && git checkout "$selected"
}

gct() {
  local selected=$(_fzf_git_tags --no-multi)
  [ -n "$selected" ] && git checkout "$selected"
}

findAndReplaceInFile()
{
  sed -i "s/$1/$2/g" $3
}

odir()
{
    cd "$(fdfind -t directory --hidden --exclude .git --exclude .github --search-path ~ | fzf --reverse --border=rounded --height 20)"
    # one return press to finish the fzf selection and other for cd
    # xdotool key Return
    # xdotool key Return
}

openfile()
{
  fdfind -t file --hidden --exclude .git --exclude .github --search-path . | fzf --reverse --border=rounded --height 20 | xargs -r nvim
}

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'
alias vim="nvim"
alias vi="nvim"
alias du='dust -r'
alias df='duf'
alias cat='batcat'
alias cmakeClean='cmake --build . --target clean'
alias cmakeConfigRel='cmake -DCMAKE_BUILD_TYPE=Release ..'
alias cmakeBuildRel='cmake --build . --target clean; cmake -DCMAKE_BUILD_TYPE=Release ..; cmake --build . --config Release -j $(nproc --ignore=2) --target'
alias cmakeBuild='cmake --build . -j $(nproc --ignore=2) --target'
alias cmakeBuildDeb='cmake --build . --target clean; cmake -DCMAKE_BUILD_TYPE=Debug ..; cmake --build . --config Debug -j $(nproc --ignore=2) --target'
alias findInFile='grep -ri '
alias la='exa --group-directories-first --icons --all --long'
alias ll='exa --group-directories-first --icons --long'
alias ls='exa --group-directories-first --icons'
alias mv='mv -vi'
alias cp='cp -v'
alias gitlog='git log -n30 --pretty="%h %s -- %an %ar"| fzf --reverse'
alias gsu='git submodule update --init --recursive --force'
alias installer='sudo apt install -yy'
alias autoremove='sudo apt autoremove -yy'
alias uninstaller='sudo apt remove'
alias updater='sudo apt update; sudo apt upgrade -yy'

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

# install agnoster theme from git
# https://github.com/shahabaz-bagwan/agnoster-bash
export THEME=$HOME/.bash/themes/agnoster-bash/agnoster.bash
if [[ -f $THEME ]]; then
   export DEFAULT_USER=`whoami`
   source $THEME
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source ~/repos/fzf-git.sh/fzf-git.sh

export EDITOR="/snap/bin/nvim"
export SUDO_ASKPASS="/usr/bin/ssh-askpass"
export VISUAL=$EDITOR
#export RANGER_LOAD_DEFAULT_RC=FALSE
export HISTFILESIZE=
export HISTSIZE=

source $HOME/repos/fzf-tab-completion/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'
bind '"\C-l": alias-expand-line'
bind -x '"\C-k": "odir"'
# bind alt+a to set the correct keymap
# use 'showkey -a' to get the keybinding you want
bind -x '"\ea": "setxkbmap us altgr-intl"'

PATH="$PATH:$HOME/.local/bin"
# . "$HOME/.cargo/env"
export IPP_ROOT="/opt/FWA/IPP"
export BOOST_BUILD_PATH="/usr/share/boost-build/src/kernel/"
export PYTHONPATH="/usr/share/gcc/python:${PYTHONPATH}"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(fzf --bash)"

# Reuse existing ssh-agent if possible
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Starting new ssh-agent..."
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519
    ssh-add ~/.ssh/office
    echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > "$SSH_ENV"
    echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> "$SSH_ENV"
    chmod 600 "$SSH_ENV"
}

# Load ssh-agent settings if possible
if [ -f "$SSH_ENV" ]; then
    source "$SSH_ENV" > /dev/null
    if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
        start_agent
    fi
else
    start_agent
fi
