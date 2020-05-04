#!/bin/bash 
source $(cd $(dirname $0); pwd -L)/common.sh

#Env variables
env_variables




# Parsing arguments
#parse_parameters ${1} ${2}
#echo "${CHECK_MARK}  parameters parsed from ${1}"

# Running pre-req checks
#run_pre_checks
#echo "${CHECK_MARK}  pre-checks done"
#echo ""




result=$(${CDP_PATH}/cdp datalake list-datalakes | jq -r '.datalakes[]."datalakeName"' 2>&1 )
echo "r : $result"
handle_exception $? "$prefix" "datalake list" "$result"

#for val in $result; do
#    echo $val
#done


echo "┃ Finished listing the dataake  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
