#!/bin/bash

. execute.sh

function getSpecificInfo() {

    param=$1
    RESULT_FILE=/tmp/results.txt

    shift
    execute "$*" > $RESULT_FILE
    grep -A 1 "> $param" $RESULT_FILE | egrep -o 'pcdata\[.*\]' | sed -e 's/pcdata\[//' -e 's/\]\]//'
    rm -f $RESULT_FILE
}

function getSpecificInfoInConfiguration() {

    METHOD_NAME_OLD=$METHOD_NAME
    export METHOD_NAME="GetConfigurationByName"
    getSpecificInfo "$@"
    export METHOD_NAME=$METHOD_NAME_OLD
}

function getSpecificInfoForEachMachineInConfiguration() {

   METHOD_NAME_OLD=$METHOD_NAME
   export METHOD_NAME="ListMachines"

   args=("$@")
   tmp=("$@")
   tmp[0]="id"
   args[5]=$(getSpecificInfoInConfiguration "${tmp[@]}")
   getSpecificInfo "${args[@]}"
   export METHOD_NAME=$METHOD_NAME_OLD
}

function getSpecificInfoInMachine() {
    METHOD_NAME_OLD=$METHOD_NAME
    export METHOD_NAME="GetMachineByName"
 
    args=("$@")
    tmp=("$@")
    unset tmp[6]
    args[5]=$(getSpecificInfoInConfiguration "${tmp[@]}")
    getSpecificInfo "${args[@]}"
    export METHOD_NAME=$METHOD_NAME_OLD
}
