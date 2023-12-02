#!/bin/bash

test $1 -gt 0 || {
  echo provide number for challenge input
  echo 'e.g.'
  echo '  ./input.sh 3'
  exit 1
}

curl `cat cookies` https://adventofcode.com/2023/day/$1/input

