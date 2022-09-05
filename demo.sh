#!/bin/bash

declare -A c
c[reset]='\033[0;0m'
c[grey]='\033[00;30m';  c[GREY]='\033[01;30m';  c[bg_GREY]='\033[40m'
c[red]='\033[0;31m';    c[RED]='\033[1;31m';    c[bg_RED]='\033[41m'
c[green]='\E[0;32m';    c[GREEN]='\033[1;32m';  c[bg_GREEN]='\033[42m'
c[orange]='\033[0;33m'; c[ORANGE]='\033[1;33m'; c[bg_ORANGE]='\033[43m'
c[blue]='\033[0;34m';   c[BLUE]='\033[1;34m';   c[bg_BLUE]='\033[44m'
c[purple]='\033[0;35m'; c[PURPLE]='\033[1;35m'; c[bg_PURPLE]='\033[45m'
c[cyan]='\033[0;36m';   c[CYAN]='\033[1;36m';   c[bg_CYAN]='\033[46m'

# print the prompt
ps1() {
    echo -ne "${c['bg_CYAN']}${c['ORANGE']}${USER}@$(hostname -s)${c['reset']}${c['CYAN']} ${c['BLUE']}$(basename $(pwd)) \$${c['reset']} "
}

# print a command
p(){
    local csize=${DEMO_CSIZE-1}
    local auto_type=${DEMO_AUTO_TYPE-no}
    local speed=${DEMO_SPEED-0.1}
    local cmd="$@"
	[[ -n $DEMO_DEBUG ]] && echo "DEBUG: DEMO_CSIZE=$csize - COMMAND: '$cmd' - DEMO_AUTO_TYPE='$auto_type'"
    ps1
    local i=0
    [[ -n $DEMO_COLOR ]] || DEMO_COLOR="reset"
    while [ $i -lt ${#cmd} ]; do
	if [ "$auto_type" != "yes" ]; then
	  read -s -n 1
	else
	  sleep $speed
	fi
        echo -ne ${c[$DEMO_COLOR]}
        echo -n "${cmd:$i:$csize}"
        echo -ne ${c["reset"]}
        i=$(($i + $csize))
    done
    # if DEMO_NOWAIT is set do not wait for the ENTER
    [[ "$DEMO_NOWAIT" == "yes" ]] || read -s
    echo
}

# print and execute
pe(){
    p "$@"
	[[ -n $DEMO_DEBUG ]] && echo "DEBUG: eval COMMAND: '$@'"
    eval "$@"
}

# print and execute immediately
pei(){
    cmd="$@"
    DEMO_CSIZE=${#cmd} pe $@
}

# print immediately
pi(){
    cmd="$@"
    DEMO_CSIZE=${#cmd} p $@
}

# execute a command until 'c' is not entered
loop(){
	cmd="$@"
	while [ "$key" != 'c' ]; do
    	$cmd 
    	read -n 1 -rep $'Press "c" to continue with the demo: \n' key
	done
}

pause(){
    read -s
}

# print
cecho(){
    local color=$2
    local message=$1
    echo -e ${c[$color]}${message}${c['reset']}
}
