#!/bin/bash

. main.sh
. retrieveInfos.sh

export METHOD_NAME="GetMachineByName"
export METHOD_ARGS="<configuration name> <machine name>"

usage "$@"

args=("$@")
args[4]=$(getSpecificInfoInConfiguration id "$*")

execute "${args[@]}"
