#!/bin/bash

. main.sh

export METHOD_NAME="GetConfigurationByName"
export METHOD_ARGS="<configuration name>"

main "$@"
