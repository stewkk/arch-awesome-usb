set -U fish_user_paths /usr/local/sbin /usr/local/bin /usr/bin /bin

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end

# Type - to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv EDITOR 'vim'
setenv SUDO_EDITOR 'vim'
setenv BROWSER 'firefox'
# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

function fish_user_key_bindings
	bind \cz 'fg>/dev/null ^/dev/null'
	bind \ee accept-autosuggestion execute
	# bind \r accept-autosuggestion execute
	bind -M normal -m insert \cf accept-autosuggestion
	# bind -M insert \ce execute
	bind -M insert \ee accept-autosuggestion execute
	bind -M insert \cf accept-autosuggestion
	# if functions -q fzf_key_bindings
	# 	fzf_key_bindings
	# end
end



function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color blue
	echo -n (hostname)
	if [ $PWD != $HOME ]
		set_color brblack
		echo -n ':'
		set_color yellow
		echo -n (basename $PWD)
	end
	set_color green
	printf '%s ' (__fish_git_prompt)
	set_color red
	echo -n '| '
	set_color normal
end

function fish_greeting
	# echo
	# echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	# echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	# echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
	# echo -e " \\e[1mDisk usage:\\e[0m"
	# echo
	# echo -ne (\
	# 	df -l -h | grep -E 'dev/(xvda|sd|mapper)' | \
	# 	awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
	# 	sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
	# 	paste -sd ''\
	# )
	# echo

	# echo -e " \\e[1mNetwork:\\e[0m"
	# echo
	# # http://tdt.rocks/linux_network_interface_naming.html
	# echo -ne (\
	# 	ip addr show up scope global | \
	# 		grep -E ': <|inet' | \
	# 		sed \
	# 			-e 's/^[[:digit:]]\+: //' \
	# 			-e 's/: <.*//' \
	# 			-e 's/.*inet[[:digit:]]* //' \
	# 			-e 's/\/.*//'| \
	# 		awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
	# 		sort | \
	# 		column -t -R1 | \
	# 		# public addresses are underlined for visibility \
	# 		sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
	# 		# private addresses are not \
	# 		sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
	# 		# unknown interfaces are cyan \
	# 		sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
	# 		# ethernet interfaces are normal \
	# 		sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
	# 		# wireless interfaces are purple \
	# 		sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
	# 		# wwan interfaces are yellow \
	# 		sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
	# 		sed 's/$/\\\e[0m/' | \
	# 		sed 's/^/\t/' \
	# 	)
	# echo

	# set r (random 0 100)
	# if [ $r -lt 5 ] # only occasionally show backlog (5%)
	# 	echo -e " \e[1mBacklog\e[0;32m"
	# 	set_color blue
	# 	echo "  [project] <description>"
	# 	echo
	# end

	# set_color normal
	# echo -e " \e[1mTODOs\e[0;32m"
	# echo
	# if [ $r -lt 10 ]
	# 	# unimportant, so show rarely
	# 	set_color cyan
	# 	# echo "  [project] <description>"
	# end
	# if [ $r -lt 25 ]
	# 	# back-of-my-mind, so show occasionally
	# 	set_color green
	# 	# echo "  [project] <description>"
	# end
	# if [ $r -lt 50 ]
	# 	# upcoming, so prompt regularly
	# 	set_color yellow
	# 	# echo "  [project] <description>"
	# end

	# # urgent, so prompt always
	# set_color red
	# # echo "  [project] <description>"

	# echo

	# if test -s ~/todo
	# 	set_color magenta
	# 	cat todo | sed 's/^/ /'
	# 	echo
	# end

	# set_color normal
end
