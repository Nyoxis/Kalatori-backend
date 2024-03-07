#!/bin/bash
IFS=.
version=($1)
target_version=($2)
# starting from minor of version if version shorter target_version
# fill absent fields in version with zeros
for ((i=${#version[@]}; i<${#target_version[@]}; i++))
do
    version[i]=0
done
# starting from major of version
for ((i=0; i<${#version[@]}; i++))
do
    if [[ -z ${target_version[i]} ]]
    then
        # if target_version shorter version then
        # fill absent fields in target_version with zeros
        ver2[i]=0
    fi
    if ((10#${version[i]} > 10#${target_version[i]}))
    then
        # if version greater than target_version in most major differing field
        exit 0
    fi
    if ((10#${version[i]} < 10#${target_version[i]}))
    then
        # if version less than target_version in most major differing field
        echo "$1 is less than $2"
        exit 1
    fi
done
echo "$1 is equal to $2"
exit 1