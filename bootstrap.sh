#!/bin/bash
app_home=$($(cd $dirname) && pwd)
cltls_conf=$app_home/cluster-tools.conf

# args: [ prop_key ]
get_prop_value(){
  value=$(cat $cltls_conf | grep ^\s*$1 | cut -d'=' -f2)
  [ -n "$value" ] && echo $value || exit 1
}

