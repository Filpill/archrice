#!/bin/sh

get_date() {
    date '+%Y %b %d (%a) | %H:%M'
}

get

while :; do
    xsetroot -name "$(get_date)"
    sleep 1m
done
