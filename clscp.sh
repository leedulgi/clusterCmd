#!/bin/bash

nodes=$(cat /etc/hosts | grep -E 'master|worker*' | awk '{print $2}')
curNode=$(hostname)
recursive=""

if [ "$1" == "-r" ];then
    recursive='-r'
    filePath=$2
    targetPath=$3
else    
    filePath=$1
    targetPath=$2
fi

if [ -z $filePath ]; then
    echo 'no file definitnion' 
    exit
fi

echo current node : $nodes
echo origin file : $filePath
echo target path : $targetPath


if [ -z $targetPath ]; then
    targetPath=dirname $filePath
fi

for node in $nodes; do
    if [ "$node" != "$curNode" ];then
        echo "cp $filePath -> ${node}:${targetPath}"
        scp -F ~/.ssh/config $1 ${node}:${targetPath}
    fi
done;    
