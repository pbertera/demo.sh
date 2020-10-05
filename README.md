# demo.sh

`demo.sh` is a very simple script that permits scripting of demos in a bash.
Commands are replyed as you type random characters.

## Features

- configurable speed of typing
- configurable colors of printed messages
- customizable prompt

## Demo

[![asciicast](https://asciinema.org/a/UwAbsPHCwbgfGflieV2vJQk5l)](https://asciinema.org/a/UwAbsPHCwbgfGflieV2vJQk5l)

The script used for the demo:

```
#!/bin/bash

. demo.sh

clear

p "# This text is printed with a speed of 1 (press ENTER now)"
p "The hash (#) in front of the line is not really needed (press ENTER now)"

SPEED=3 p "# This text is printed with a speed of 3 (press ENTER now)"
COLOR=RED pi "# This text is printed immediately and RED (you should have learned to press ENTER now :) )"
pe 'echo "This is a command printed and executed"'
SPEED=2 pe 'echo "This is a command printed and executed at speed 2"'

pi "# The following command is just printed and not executed, just a fake:"
pi 'RESULT=$(curl -s -X POST --data-urlencode client_id=cloud-services https://myserver.com/api/action)'
RESULT='{"result": "ok"}'

pei 'echo $RESULT'

COLOR=blue pi "# Let's change the prompt now"

ps1() {
    echo -ne "\033[01;32m${USER}@$(hostname -s) \033[01;34m$(basename $(pwd)) \$ \033[00m"
}

pi '# At the end I'"'"'m just a normal bash script, just be careful about quoting :)'
for i in $(seq 0 3); do
    pe "echo I am in a loop: $i"
done

COLOR=ORANGE pi "Goodbye !"
sleep 3
clear
```

### Credits

- [doitlive](https://github.com/sloria/doitlive): very nice and sofisticated tool but [painful to use with variables](https://github.com/sloria/doitlive/issues/32)
- [demo-magig](https://github.com/paxtonhare/demo-magic): nice idea but requires [pv](http://www.ivarch.com/programs/pv.shtml)
