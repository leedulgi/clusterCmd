#!/bin/bash

clcmd_home=$(cd $(dirname $0) && pwd)
clcmd_conf=$clcmd_home/clcmd.conf

echo clcmd home : $clcmd_home

if [ -z $1 ] ; then
  echo no command
  exit
fi


#nodes=$(cat /etc/hosts | grep -E 'master|worker*' | awk '{print $2}')
nodes=$(cat $clcmd_conf | grep nodes | cut -d'=' -f2)
echo nodes : $nodes

#curNode=$(hostname)
cmd=$@

for node in $nodes; do
  ssh $node $cmd
done;    
