#!/bin/bash

# scss and coffee have watch routines. vim saving would confuse
# coffee-script watch and cause it to stop monitoring files, so I wrote
# this using inotify-tools. Will work on linux.

highlight() {
    echo -e "\007"
}

inotifywait -e modify -m web scss | while read line ; do
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
    esac
done
