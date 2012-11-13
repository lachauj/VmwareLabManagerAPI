#!/bin/bash

. usefulFunctions.sh
. execute.sh

export SERVER_LAB_MANAGER="https://[host]/LabManager/SOAP/LabManager.asmx"

function main() {

    usage "$@"
    execute "$*"
}