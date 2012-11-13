#!/bin/bash

. main.sh
. retrieveInfos.sh

export METHOD_NAME="ConfigurationClone"
export METHOD_ARGS="<configuration name> <new workspace name>"

usage "$@"

args=("$@")
args[4]=$(getSpecificInfoInConfiguration id "$*")

execute "${args[@]}"
