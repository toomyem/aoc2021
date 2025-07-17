#!/bin/bash

set -euo pipefail

day=$1
nr=$(printf "%02d" "$day")
input=${2:-inputs/input$nr.txt}

if [[ "$input" != "-" ]] && [[ ! -s "$input" ]]
then
  echo "Download input for day $day"
  mkdir -p "inputs"
  wget -q -O "$input" --header "Cookie: session=${SESSION:?is not set}" "https://adventofcode.com/2021/day/$day/input"
fi

exe="gleam run $day"

if [[ "$input" = "-" ]]
then
  $exe
else
  $exe < "$input"
fi
