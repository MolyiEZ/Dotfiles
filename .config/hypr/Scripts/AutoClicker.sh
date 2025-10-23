#!/bin/bash

trap "exit" INT TERM
while :; do
  ydotool click 0x00
done
