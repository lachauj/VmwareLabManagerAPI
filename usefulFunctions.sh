#!/bin/bash

function retrieveDate() {
    test $# -ge 1 && date --date "$1 days" "+%Y-%m-%d" || date "+%Y-%m-%d"
}

function toLower() {
    echo "$1" | tr '[A-Z]' '[a-z]'
}

function countArgs() {
    echo "$1" | egrep -o ">" | wc -l
}

function usage() {
    nb_args=$(countArgs "$METHOD_ARGS")

    test $# -lt "$((nb_args + 4))" && echo "usage: $0 <username> <password> <organization name> <workspace name> $METHOD_ARGS" && exit 1
}

function posItemInArray() {
    item=$(toLower $1)
    array=("${!2}")
    lengthArray=${#array[@]}

    for ((i=0; i < $lengthArray; ++i))
    do
	test $item == ${array[$i]} && echo $((i + 1))
    done

}

function optionsAvailable() {

    echo "The options available are (case insensitive):"
    for item in $*
    do
	echo -e "\t-$item"
    done
}

function checkOptionExists() {
    
    option=$(toLower $1)
    exists=0
    shift
    for item in $*
    do
	test $option == $item && exists=1
    done

    test $exists == 0 && echo "The option $option does not exist" && optionsAvailable "$@" && return 1

    return 0
}

function waitServerIsUp() {
	server=$1
	port=$2
	timeout=$3
	timestamp=$(date +%s)
	timestop=$((timestamp + timeout))

	while [ $(date +%s) -le $timestop ];
	do
		exec 7<>/dev/tcp/$server/$port
		test $? == 0 && exec 7<&- && return 0
		sleep 1
	done
	
	return 1
}
