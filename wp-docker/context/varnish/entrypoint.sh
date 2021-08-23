#!/bin/bash

# Start the first process
/usr/sbin/varnishd \
         -P /var/run/varnish.pid \
         -f $VARNISH_VCL_CONF \
         -a ${VARNISH_LISTEN_ADDRESS}:${VARNISH_LISTEN_PORT} \
         -T ${VARNISH_ADMIN_LISTEN_ADDRESS}:${VARNISH_ADMIN_LISTEN_PORT} \
         -s malloc,$VARNISH_STORAGE 
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start varnishd: $status"
  exit $status
fi

# Start the second process
/usr/bin/varnishncsa \
    -a \
    -w /proc/self/fd/1 \
    -D \
    -P /run/varnishncsa.pid \
    -F '{\"@timestamp_real\": \"%{%Y-%m-%dT%H:%M:%S%z}t\", \"client_ip\":\"%{X-Actual-IP}i\", \"remote_use\" : \"%u\", \"http_host\":\"%{host}i\", \"x_forwarded_for\" : \"%{X-Forwarded-For}i\", \"duration_usec\": %D, \"http_method\":\"%m\", \"http_request\":\"%U\",\"http_query\": \"%q\", \"http_version\": \"%H\", \"status_code\": %s, \"bytes\": %b, \"http_referrer\":\"%{Referer}i\", \"user_agent\":\"%{User-agent}i\", \"hit_miss\":\"%{Varnish:hitmiss}x\", \"handling\" : \"%{Varnish:handling}x\", \"time_first_byte\" : \"%{Varnish:time_firstbyte}x\"}'
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start varnishncsa: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 60; do
  ps aux |grep varnishd |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep varnishncsa |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done