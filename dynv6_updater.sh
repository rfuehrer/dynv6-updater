#!/bin/bash
myarray=(`echo $DYNV6_SERVERS | tr ',' ' '`)

#echo "My array: ${myarray[@]}"
#echo "Number of elements in the array: ${#myarray[@]}"

for (( i=0; i<=${#myarray[@]}-1; i++ )); do
    #echo "#$i: ${myarray[$i]}"
    token=$DYNV6_TOKEN /code/dynv6.sh "${myarray[$i]}"
done
