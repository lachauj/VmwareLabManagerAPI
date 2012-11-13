#!/bin/bash

. main.sh
. retrieveInfos.sh
. usefulFunctions.sh

export METHOD_NAME="MachinePerformAction"
export METHOD_ARGS="<configuration name> <machine name> <action>"

usage "$@"

args=("$@")
tmp=("$@")
unset tmp[6]
args[4]=$(getSpecificInfoInMachine id "${tmp[@]}")

ACTIONS=(
    poweron
    poweroff
    suspend
    resume
    reset
    snapshot
    revert
    shutdown
)

(! checkOptionExists ${args[6]} ${ACTIONS[@]}) && exit 1 

args[5]=$(posItemInArray ${args[6]} ACTIONS[@])
unset args[6]

execute "${args[@]}"
