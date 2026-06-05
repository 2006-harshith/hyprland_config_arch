#!/usr/bin/env bash

if pgrep -f observatory-open >/dev/null; then
    rm /tmp/observatory-open
else
    touch /tmp/observatory-open
fi