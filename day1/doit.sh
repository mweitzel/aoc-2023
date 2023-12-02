#!/bin/bash

first() {
  local input="$@"
  echo $input | grep -o -E '[0-9]' | head -n 1
}

last() {
  local input="$@"
  first `echo $input | rev`
}

lines_to_numbers() {
  while read line
  do
    a=`first "$line"`
    b=`last "$line"`
    echo $a$b
  done
}

prepare_sum() {
  while read line
  do
    echo -n $line ' + '
  done
  echo 0
}

sum() {
  prepare_sum | bc
}


main() {
  cat input | lines_to_numbers| sum
}

main
