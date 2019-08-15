#!/bin/bash

OPTS="${OPTS:-}"
TIMEOUT="${TIMEOUT:-0}"
seconds=0

if [ $TIMEOUT -gt 0 ]; then
  echo 'Waiting up to' $TIMEOUT 'seconds for HTTP 200 from' $URL
  until [ "$seconds" -gt "$TIMEOUT" ] || $(curl $OPTS --output /dev/null --silent --max-time $TIMEOUT --head --fail $URL); do
    printf '.'
    sleep 5
    seconds=$((seconds+5))
  done

  if [ "$seconds" -lt "$TIMEOUT" ]; then
    echo 'OK'
  else
    echo "ERROR: Timed out wating for HTTP 200 from" $URL >&2
    exit 1
  fi
else
  echo 'Waiting indefinitely for HTTP 200 from' $URL
  until $(curl $OPTS --output /dev/null --silent --max-time $TIMEOUT --head --fail $URL); do
    printf '.'
    sleep 5
  done

  echo 'OK'
fi
