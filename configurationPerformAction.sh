#!/bin/bash

. main.sh
. retrieveInfos.sh
. usefulFunctions.sh

export METHOD_NAME="ConfigurationPerformAction"
export METHOD_ARGS="<configuration name> <action>"

usage "$@"

args=("$@")
args[4]=$(getSpecificInfoInConfiguration id "$*")

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

(! checkOptionExists ${args[5]} ${ACTIONS[@]}) && exit 1

args[5]=$(posItemInArray ${args[5]} ACTIONS[@])

execute "${args[@]}"
