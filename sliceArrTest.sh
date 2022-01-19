#!/usr/bin/env bash

# replacing to zero string is not work to split
arr=( 1 2 3 4 5 ) 
echo ${arr[@]}
arr[0]=""
echo ${arr[@]}

echo arr[0] : ${arr[0]}
echo arr[1] : ${arr[1]}


# to split array, it could followed way
arr=("${arr[@]:2}")
echo ${arr[@]}
echo arr[0] : ${arr[0]}
echo arr[1] : ${arr[1]}

# how about string
str="1 2 3 4 5 "
echo str[0] : ${str[0]}
str[0]=''
echo $str

# Parenthesis make string to array by IFS
