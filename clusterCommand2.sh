#!/bin/bash -x

CLC_HOME=dirname $0
CLC_CONF=${CLC_HOME}/clc.conf

nodes=""
clc=""

echo clusterCommand

function help {
    echo clusterCmd
    echo "    -l <server list id>
    echo "    -h  help"
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
    local option
#    set -x
    echo $@

    local OPTIND
    while getopts ":*" opt; do
        case $opt in
            ?) 
            eval option=$option \$$(expr $OPTIND - 1)
            echo option:$option
            ;;
        esac
    done
    echo OPTIND:$OPTIND
    eval filePath=\$$OPTIND
    eval destPath=\$$(expr $OPTIND + 1)
    if [ $# -lt 1 ]; then
        clscpHelp
        return 1
    fi
    if [ -z $destPath ]; then
        destPath=$filePath
        echo destPath:$destPath
    fi
    setclopts -o
    for node in $nodes; do
        echo "scp $option $filePath > ${node}:$destPath"
#        scp $option $filePath ${node}:$destPath
    done
#    set +x
}

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



function init {
    OPTIND=1

#    nodes=$(grep -E "worker|master" /etc/hosts | awk '{print $2}')

    while getopts aowmh opt; do
        case $opt in
            l)
                nodes=$(grep '^\s*' ${CLC_CONF})
                scp 
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
    if [ -z $nodes ]; do
        nodes=
    echo target nodes : $nodes
}

function main {
    init $@

}

#test
