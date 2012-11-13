#!/bin/bash

. main.sh
. retrieveInfos.sh

export METHOD_NAME="ConfigurationUndeploy"
export METHOD_ARGS="<configuration name>"

usage "$@"

args=("$@")
args[4]=$(getSpecificInfoInConfiguration id "$*")

execute "${args[@]}"
