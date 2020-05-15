#!/bin/bash

APPS=(
    ntrip_caster
)

while true
do
    sleep 1
    for app in ${APPS[*]}
    do
        echo "$0: checking $app running..."
        if ! pidof $app > /dev/null; then
            echo "$0: restart $app..."
            (./$app &)
        fi
        echo "$0: checking $app done"
    done
done

exit $?

