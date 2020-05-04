#!/bin/bash 
source $(cd $(dirname $0); pwd -L)/common.sh

 display_usage() { 
	echo "
Usage:
    $(basename "$0") <datalake_name> <datalake_action> [--help or -h]

Description:
    Starts or stops  datalake based on name and action passed

Arguments:
    arg_1: name of datalake 
    arg_2: action to be performed. valid options are start/stop/describe/status                                    "

}


# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 


# Check the numbers of arguments
if [  $# -lt 2 ] 
then 
    echo "Not enough arguments!"  >&2
    display_usage
    exit 1
fi 

if [  $# -gt 2 ] 
then 
    echo "Too many arguments!"  >&2
    display_usage
    exit 1
fi 


echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Starting to Execute $2 on $1     ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo ""
echo ""
echo "⏱  $(date +%H%Mhrs)"
echo ""
echo "Parsing parameters and running pre-checks:"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"


#Env variables
env_variables


datalake_name=${1}
prefix=${1}
action=`echo ${2}| tr '[:upper:]' '[:lower:]'`

# Parsing arguments
#parse_parameters ${1} ${2}
#echo "${CHECK_MARK}  parameters parsed from ${1}"

# Running pre-req checks
#run_pre_checks
#echo "${CHECK_MARK}  pre-checks done"
#echo ""


case ${action} in

start)

# start 

dl_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh dl  $datalake_name | jq -r .datalake.status)
if [ "$dl_status" != "RUNNING" ]
then
    result=$(${CDP_PATH}/cdp datalake start-datalake --datalake-name $datalake_name 2>&1 > /dev/null)
    handle_exception $? "$prefix" "datalake start" "$result"
fi
dl_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh dl  $datalake_name | jq -r .datalake.status)

spin='🌑🌒🌓🌔🌕🌖🌗🌘'
while [ "$dl_status" != "RUNNING" ]
do 
    i=$(( (i+1) %8 ))
    printf "\r${spin:$i:1}  $prefix: datalake status: $dl_status                              "
    sleep 2
    dl_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh dl  $datalake_name | jq -r .datalake.status)
done

printf "\r${CHECK_MARK}  $prefix: datalake status: $dl_status                                 "

echo "⏱  $(date +%H%Mhrs)"

echo ""
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Finished to stop the dataake  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
;;

stop)

dl_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh dl  $datalake_name | jq -r .datalake.status)
if [ "$dl_status" != "STOPPED" ]
then
    result=$(${CDP_PATH}/cdp datalake stop-datalake --datalake-name $datalake_name 2>&1 > /dev/null)
    handle_exception $? "$prefix" "datalake stop" "$result"
fi
dl_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dl  $datalake_name | jq -r .datalake.status)

spin='🌑🌒🌓🌔🌕🌖🌗🌘'
while [ "$dl_status" != "STOPPED" ]
do
    i=$(( (i+1) %8 ))
    printf "\r${spin:$i:1}  $prefix: datalake status: $dl_status                              "
    sleep 2
    dl_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dl $datalake_name | jq -r .datalake.status)
done

printf "\r${CHECK_MARK}  $prefix: datalake status: $dl_status                                 "

echo "⏱  $(date +%H%Mhrs)"


echo ""
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Finished to stop the dataake  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"


;;

status)

dl_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dl $datalake_name | jq -r .datalake.status)
printf "\r${CHECK_MARK} datalake status: $dl_status                                 "
echo "⏱  $(date +%H%Mhrs)"
echo ""
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Finished to get status the dataake  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"


;;


*)
		echo "Invalid value for action. refer usage"
                display_usage 
		;;
esac
