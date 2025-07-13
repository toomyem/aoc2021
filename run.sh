#!/bin/bash

set -euo pipefail

day=$1
nr=$(printf "%02d" "$day")
input=input$nr.txt

if [[ ! -s "$input" ]]
then
  echo "Download input for day $day"
  wget -q -O "$input" --header "Cookie: session=${SESSION:?is not set}" "https://adventofcode.com/2021/day/$day/input"
fi

exe="gleam run $day"

if [[ "$input" = "-" ]]
then
  $exe
else
  $exe < "$input"
fi
