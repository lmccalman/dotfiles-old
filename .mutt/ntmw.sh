#!/usr/bin/env sh

notmuch address --output=recipients --deduplicate=address date:1Y.. AND from:lachlan.mccalman@nicta.com.au  $1 \
     |sed -s 's/\(.*\) \(<.*\)/\1\   \2/'\
     | sed -s 's/\"//g'
