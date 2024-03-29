# My fish configs

export TERMINAL="/usr/local/bin/st"
export EDITOR="/usr/bin/vim"
export SUDO_ASKPASS="/usr/bin/ssh-askpass"
export VISUAL=$EDITOR
export RANGER_LOAD_DEFAULT_RC=FALSE

source ~/.local/share/icons-in-terminal/icons.fish
#https://github.com/Yash-Handa/logo-ls/releases

# aliases 
#alias la 'ls -AlhN --color=auto --group-directories-first'
#alias ll 'ls -lhN --color=auto --group-directories-first'

abbr cmakeClean 'cmake --build . --target clean'
abbr cmakeConfigRel 'cmake -DCMAKE_BUILD_TYPE=Release ..'
abbr cmakeBuildRel 'cmake --build . --target clean; cmake -DCMAKE_BUILD_TYPE=Release ..; cmake --build . --config Release --parallel --target'
abbr cmakeBuild 'cmake --build . --parallel --target'
abbr cmakeBuildDeb 'cmake --build . --target clean; cmake -DCMAKE_BUILD_TYPE=Debug ..; cmake --build . --config Debug --parallel --target'
abbr c 'clear'
abbr q 'exit'
abbr la 'logo-ls -A'
abbr ll 'logo-ls -lh'
abbr ls 'logo-ls'
abbr rm 'rm -vI'
abbr mv 'mv -vi'
abbr cp 'cp -v'
abbr r 'ranger'
abbr gs 'git status'
abbr gc 'git commit -m'
abbr gcl 'git clone '
abbr ga 'git add'
abbr gaa 'git add -A'
abbr gap 'git add -p'
abbr gp 'git push'
abbr gpl 'git pull'
abbr gpla 'git pull --all --tags'
abbr gd 'git diff'
abbr gr 'git remote'
abbr grv 'git remote -v'
abbr grs 'git remote set-url origin'
abbr gra 'git remote add origin'
abbr installer 'sudo apt install -yy'
abbr autoremove 'sudo apt autoremove -yy'
abbr uninstaller 'sudo apt remove'
abbr purger 'sudo apt remove --purge -yy'
abbr updater 'sudo apt update; sudo apt upgrade -yy'

# theme settings usign Oh-My-Fish
set -g theme_color_scheme dark
set -g theme_date_timezone Europe/Berlin
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no

function fish_user_key_bindings
	bind \cH backward-kill-word
end
