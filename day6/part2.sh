#!/bin/bash

echo ' 58996469 478223210191071' | awk -v powers=1 '
{
  t=$1
  best=$2
  betters=0
  for (i = 1; i <= t; i++)
  {
    duration = i;
    if (((t - duration) * duration) > best) {
      betters = betters + 1;
    }
  }
  powers = powers * betters
  print betters
  print powers
  print ""
}
'
