#!/bin/bash

bin_path=$(cd $(dirname $0) && pwd)
home_path=$(dirname $bin_path)
#tmp
config_path=$home_path/cluster-tools.conf

curNode=$(cat $config_path | grep ^\s*curNode | cut -d'=' -f2)
target_nodes=$(cat $config_path | grep ^\s*nodes | cut -d'=' -f2) 
target_user=$(cat $config_path | grep ^\s*target_user | cut -d'=' -f2)

# code for remove curNode from target_nodes
if [[ $target_nodes == *"${curNode}"* ]]; then
  target_nodes=$(echo $target_nodes | sed "s/$curNode//" )
fi
# code forset curNode automatically
#if [[ -z $curNode ]]; then
#  curNode=$(hostname -a)
# hostname -a is deprecated
#fi

echo current node : $curNode
echo target nodes : $target_nodes
echo target user : $target_user

#export target_nodes config_path
