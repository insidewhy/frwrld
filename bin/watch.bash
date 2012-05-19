#!/bin/bash

# scss and coffee watch sometimes crash to it's best to run them in little
# loops like this.

sleepfor=2 # to avoid bomb in case of disaster

watch_scss() {
    while true ; do
        scss --compass --watch scss:static/styles
        sleep $sleepfor
    done
}

watch_coffee() {
    while true ; do
        ./node_modules/coffee-script/bin/coffee  -o static/js -w web/*.coffee
        sleep $sleepfor
    done
}

bye() {
    kill $(jobs -p)
    echo stopped watching
}

trap "bye" SIGINT SIGTERM

watch_scss &
watch_coffee &
wait
