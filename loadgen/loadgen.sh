#!/bin/bash

INTERVAL_RANGE_SEC="${INTERVAL_RANGE_SEC:-5}"
ENDPOINT="${ENDPOINT:-http://localhost}"

while true; do
  delay=$((1 + $RANDOM % $INTERVAL_RANGE_SEC))
  sleep $delay
  curl $ENDPOINT ; echo " [${delay}s]"
done
