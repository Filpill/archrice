#!/bin/sh

get_date() {
    date '+%Y %b %d (%a) | %H:%M'
}

while :; do
    xsetroot -name "$(get_date)"
    sleep 15s
done
