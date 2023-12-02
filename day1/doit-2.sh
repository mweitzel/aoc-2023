#!/bin/bash

num_words() {
 echo '0|1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine'
}

translate() {
  sed 's/one/1/' |
  sed 's/two/2/' |
  sed 's/three/3/' |
  sed 's/four/4/' |
  sed 's/five/5/' |
  sed 's/six/6/' |
  sed 's/seven/7/' |
  sed 's/eight/8/' |
  sed 's/nine/9/'
}

first() {
  local input="$@"
  echo $input | grep -o -E '('`num_words`')' | head -n 1 | translate | translate
}

last() {
  local input="$@"
  echo $input | rev | grep -o -E '('`num_words|rev`')' | head -n 1| rev | translate | translate
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
  cat input | lines_to_numbers | sum
}

main
