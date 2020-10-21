# aliases 
alias la 'll -a'
alias rm 'rm -vI'
alias mv 'mv -vi'
alias cp 'cp -v'
alias r 'ranger'
# theme settings usign Oh-My-Fish
set -g theme_color_scheme light
set -g theme_date_timezone Europe/Berlin
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no

function fish_user_key_bindings
	bind \cH backward-kill-path-component
end
