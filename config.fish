# aliases 
alias la 'ls -AlhN --color=auto --group-directories-first'
alias ll 'ls -lhN --color=auto --group-directories-first'
alias rm 'rm -vI'
alias mv 'mv -vi'
alias cp 'cp -v'
alias r 'ranger'
alias gs 'git status'
alias gc 'git commit -m'
alias ga 'git add'
alias gd 'git diff'
alias installer 'sudo apt install -yy'
alias autoremove 'sudo apt autoremove -yy'
alias uninstaller 'sudo apt remove'
alias purger 'sudo apt remove --purge -yy'
alias updater 'sudo apt update; sudo apt upgrade -yy'

# Defaults
export EDITOR="/usr/local/bin/vim"
export VISUAL="$EDITOR"
export TERMINAL="/usr/local/bin/st"

# theme settings usign Oh-My-Fish
set -g theme_color_scheme dark
set -g theme_date_timezone Europe/Berlin
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no

function fish_user_key_bindings
	bind \cH backward-kill-word
end
