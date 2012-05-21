#!/bin/bash

# scss and coffee have watch routines. vim saving would confuse
# coffee-script watch and cause it to stop monitoring files, so I wrote
# this using inotify-tools. Will work on linux.

highlight() {
    echo -e "\007"
}

runserver() {
    ./node_modules/coffee-script/bin/coffee server.coffee &
}

(echo first ; inotifywait -e modify -m web scss .) | while read line ; do
    if [[ $line = first ]] ; then
        # have to run server in read loop else can't kill job
        runserver
        continue
    fi
    [[ $line = *.swp ]] && continue
    case $line in
        web/*)
            echo "updating javascript"
            ./node_modules/coffee-script/bin/coffee -o static/js web/*.coffee \
                || highlight
            ;;
        scss/*)
            echo "updating scss"
            scss --compass --update scss:static/styles || highlight
            ;;
        ./*)
            [[ $line != *.coffee ]] && continue
            kill $(jobs -p)
            wait
            runserver
            ;;
    esac
done
