PROPERTIES_FILE=/tmp/labManagerProperties.txt
REQUEST_FILE=/tmp/request.txt

function generatePropertiesFile() {

    echo -n > $PROPERTIES_FILE

    for arg in $*
    do
	echo $arg >> $PROPERTIES_FILE
    done
}

function generateRequest() {
 
    wsdl -g -e "$SERVER_LAB_MANAGER"?WSDL $METHOD_NAME < $PROPERTIES_FILE | egrep -o "<.*>" > $REQUEST_FILE
}

function execute() {

    generatePropertiesFile "$*"
    generateRequest
    
    curl -k -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:" -d @$REQUEST_FILE -X POST "$SERVER_LAB_MANAGER" 2>/dev/null | xml_parser 
2>/dev/null
}
