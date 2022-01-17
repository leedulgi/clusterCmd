#!/bin/bash

clcmd_home=$(cd $(dirname $0) && pwd)
clcmd_conf=$clcmd_home/clcmd.conf

nodes=$(cat $clcmd_conf | grep nodes | cut -d'=' -f2)

curNode=$(hostname)
recursive=""

orgPath=$1
destPath=$2

echo target nodes : $nodes
echo origin path : $orgPath
#echo destination path : $destPath
echo destination path : $destPath

#not support tilde yet
if [[ "$destPath" == ${HOME}* ]];then
  echo not support tilde yet. enter Fully Qualified Path
  exit
fi

if [ -d $orgPath ];then
  echo is directory : 'true'
  recursive='-r'
elif [ -f $orgPath ];then    
  recursive=""
else
  echo there\'s no file
  exit
fi

if [ -z $orgPath ]; then
  echo 'no origin file path definitnion' 
  exit
fi

if [ -z $destPath ]; then
  destPath=$(cd$(dirname $orgPath) && pwd)
fi

for node in $nodes; do
  if [ "$node" != "$curNode" ];then
echo $2
echo '$2'
#eval  ssh $node echo '$destPath'
    echo "cp $orgPath -> ${node}:${destPath}"
    scp -F ~/.ssh/config $recursive $orgPath ${node}:${destPath}
#    scp -F ~/.ssh/config $recursive $orgPath ${node}:$(${destPath})
  fi
done;    
