#!/bin/bash

echo '58 478
99 2232
64 1019
69 1071' | awk -v powers=1 '
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
