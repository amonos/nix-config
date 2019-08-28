#!/bin/bash

if [ -z $1 ]
then
    BRANCH=master
else
    BRANCH=$1
fi


for d in */; do
    pushd $d > /dev/null 2>&1
    if [ -d '.git' ]
    then
        echo -e "\033[1;94m>>>>>>>> $d\033[0m"
        git checkout $BRANCH && git pull
    fi
    popd > /dev/null 2>&1
done
