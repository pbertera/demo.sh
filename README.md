# demo.sh

`demo.sh` is a very simple script that permits scripting of demos in a bash.
Commands are replyed as you type random characters.

- The `DEMO_CSIZE` variable defines how many chars to print
- If the env variable `DEMO_AUTO_TYPE` is set to `yes` the commands will be sent without pressing ENTER
- The `DEMO_SPEED` variable define the speed of the fake typing
- If the env variable `DEMO_NOWAIT` is set the script do not need the enter to send a command
- Setting the `DEMO_DEBUG` env variable will enable some debug outupt

## Features

- configurable speed of typing
- configurable colors of printed messages
- customizable prompt

## Demo

[![asciicast](https://asciinema.org/a/8MLff6zn1BkimNkKOfJIXX1CT.svg)](https://asciinema.org/a/8MLff6zn1BkimNkKOfJIXX1CT)

The script used for the demo:

```
#!/bin/bash

. demo.sh

clear

p "# The 'p' command just prints something without executing nothing. You need to press ENTER to continue. Useful to show instructions like that"
p "# This text is printed with a DEMO_CSIZE=1 (one char at time) (press ENTER now)"
p "The hash (#) in front of the line is not really needed (press ENTER now)"

DEMO_CSIZE=3 p "# This text is printed with a DEMO_CSIZE=3 (press ENTER now)"

p "# The 'pi' command is like 'p' but prints the whole line"
pi "# This text is printed immediately (you should have learned to press ENTER now :) )"

pe 'echo "This is a command printed and executed"'

pi '# setting the DEMO_COLOR variable can change the color'
DEMO_COLOR=red pi '# This is red'

pi '# you can configure how many chars to print with DEMO_CSIZE var'
DEMO_CSIZE=5 pe 'echo "This is a command printed and executed with DEMO_CSIZE=5"'

pi "# The following command is just printed and not executed, just a fake:"
pi 'RESULT=$(curl -s -X POST --data-urlencode client_id=cloud-services https://myserver.com/api/action)'
RESULT='{"result": "ok"}'
pei 'echo $RESULT'

DEMO_COLOR=blue pi "# Let's change the prompt now"

ps1() {
    echo -ne "\033[01;32m${USER}@$(hostname -s) \033[01;34m$(basename $(pwd)) \$ \033[00m"
}

pi '# At the end I'"'"'m just a normal bash script, just be careful about quoting :)'
for i in $(seq 0 3); do
    pe "echo I am in a loop: $i"
done

p '# the following will loop executing the "ip addr" command until you press "c"'
loop pe ip addr

p '# setting DEMO_AUTO_TYPE=yes will type the command automatically'
pe DEMO_AUTO_TYPE=yes

pe DEMO_CSIZE=10
p '# you can control the speed of typing with DEMO_CSIZE and DEMO_SPEED'

pe DEMO_CSIZE=1 DEMO_SPEED=0.5
p '# Slow text'

pe DEMO_CSIZE=1 DEMO_SPEED=0.01
p '# Fast text'

p '# setting DEMO_NOWAIT=yes will automatically send the command without pressing enter'
pe DEMO_NOWAIT=yes

pe 'echo "this is completely automatic"'

COLOR=ORANGE pi "Goodbye !"
sleep 3
clear
```

### Credits

- [doitlive](https://github.com/sloria/doitlive): very nice and sofisticated tool but [painful to use with variables](https://github.com/sloria/doitlive/issues/32)
- [demo-magig](https://github.com/paxtonhare/demo-magic): nice idea but requires [pv](http://www.ivarch.com/programs/pv.shtml)
