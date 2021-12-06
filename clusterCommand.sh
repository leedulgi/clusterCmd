#!/bin/bash -x

#hadoop cluster
#find slave nodes from /etc/hosts

nodes=""

echo clusterCommand

function help {
    echo clusterCmd
    echo "    -a  all nodes"
    echo "    -o  other nodes"
    echo "    -w  workers"
    echo "    -m  masters"
    echo "    -h  help"
}


function setclopts {
    OPTIND=1
    nodes=$(grep -E "worker|master" /etc/hosts | awk '{print $2}')
    while getopts aowmh opt; do
        case $opt in
            a)
                nodes=$(grep -E "worker|master" /etc/hosts | awk '{print $2}')
                ;;
            o)
                curNode=$(hostname)
                echo curNode : $curNode
                nodes=$(grep -E "worker|master" /etc/hosts | grep -v $curNode | awk '{print $2}')
                ;;
            w)
                nodes=$(grep "worker" /etc/hosts | awk {prinf $2})
                ;;
            m)
                nodes=$(grep "master" /etc/hosts | awk {prinf $2})
                ;;
            h)
                help
                return 0
                ;;
            ?)
                help
                return 1
                ;;
        esac
    done
    echo target nodes : $nodes
}

#execute command at nodes
function clcmd {
#set -x
    setclopts $*
    acmd=($*)
    local cmd=${acmd[$OPTIND-1]}
    for ((i=$OPTIND; i<=$#; i++)); do
        cmd="$cmd ${acmd[$i]}"
    done
#set +x
    echo cmd:$cmd
    for node in ${nodes[@]}
        do ssh $node $cmd
    done
}

function clscpHelp {
    echo clscp 
    echo     syntax : clscp filePath [destPath]
}

function clscp {
    filePath=$1
    destPath=$2
    if $#<1; then
        clscpHelp
        exit 1
    fi
    if [ -z destPath ]; then
        destPath=$filePath
    fi
    setclopts -o
    for node in $nodes; do
        echo cp $filePath > ${node}:${destPath}
#scp $node 
    done
}

#function clscp {
#    setclopts $*
#    for node in $(otherNodes); do
#        cat $1 | ssh $node "sudo tee $1" > /dev/null 2>&1
#    done
#}

#reboot nodes
function clrb {
    getclopts $*
    clusterCmd sudo shutdown -r now
}

#shutdown nodes
function clsd {
    getclopts $*
    clusterCmd sudo shutdown now
}




#test
