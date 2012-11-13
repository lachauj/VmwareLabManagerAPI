#!/bin/bash

. usefulFunctions.sh
. execute.sh

export SERVER_LAB_MANAGER="https://bsgenlm.bstlabrd.fr.alcatel-lucent.com/LabManager/SOAP/LabManager.asmx"

function main() {

    usage "$@"
    execute "$*"
}