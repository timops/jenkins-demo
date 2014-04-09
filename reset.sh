#!/bin/bash

VBOXES='master slave'
CLIENTS='jenkins-master jenkins-slave'

for box in $VBOXES
do
  echo "destroying vm: [$box] ..."
  vagrant destroy $box -f
done

for client in $CLIENTS
do
  echo "removing client and node object for: [$client] ..."
  knife client delete $client -y
  knife node delete $client -y
done
