#!/bin/bash 
source $(cd $(dirname $0); pwd -L)/common.sh

 display_usage() { 
	echo "
Usage:
    $(basename "$0") <datahub_name> <datahub_action> [--help or -h]

Description:
    Starts or stops  datahub cluster based on name and action passed

Arguments:
    arg_1: name of datahub cluster
    arg_2: action to be performed. valid options are start/stop                               "

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
echo "┃ Starting to Execute              ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo ""
echo ""
echo "⏱  $(date +%H%Mhrs)"
echo ""
echo "Parsing parameters and running pre-checks:"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"


#Env variables
env_variables


datahub_name=${1}
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

dh_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dh $datahub_name | jq -r '.cluster.status')
if [ "$dh_status" != "AVAILABLE" ]
then
    result=$(${CDP_PATH}/cdp datahub start-cluster --cluster-name $datahub_name 2>&1 > /dev/null)
    handle_exception $? "$prefix" "datahub start" "$result"
fi
dh_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dh $datahub_name | jq -r '.cluster.status')

spin='🌑🌒🌓🌔🌕🌖🌗🌘'
while [ "$dh_status" != "AVAILABLE" ]
do 
    i=$(( (i+1) %8 ))
    printf "\r${spin:$i:1}  $prefix: datahub cluster status: $dh_status                              "
    sleep 2
    dh_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh dh  $datahub_name | jq -r '.cluster.status')
done

printf "\r${CHECK_MARK}  $prefix: datahub cluster status: $dh_status                                 "

echo "⏱  $(date +%H%Mhrs)"

echo ""
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Finished to start the datahub cluster  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
;;

stop)

dh_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dh $datahub_name | jq -r '.cluster.status')
if [ "$dh_status" != "STOPPED" ]
then
    result=$(${CDP_PATH}/cdp datahub stop-cluster --cluster-name $datahub_name 2>&1 > /dev/null)
    handle_exception $? "$prefix" "datahub stop" "$result"
fi
dh_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dh $datahub_name | jq -r '.cluster.status')

spin='🌑🌒🌓🌔🌕🌖🌗🌘'
while [ "$dh_status" != "STOPPED" ]
do
    i=$(( (i+1) %8 ))
    printf "\r${spin:$i:1}  $prefix: datahub cluster status: $dh_status                              "
    sleep 2
    dh_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh dh  $datahub_name | jq -r '.cluster.status')
done

printf "\r${CHECK_MARK}  $prefix: datahub status: $dh_status                                 "

echo "⏱  $(date +%H%Mhrs)"


echo ""
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Finished to stop the datahub cluster  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"


;;

status)

dh_status=$(${BASE_SCRIPT_DIR}/cdp_entity_describe.sh  dh $datahub_name | jq -r '.cluster.status')
printf "\r${CHECK_MARK} datahub cluster status: $dh_status                                 "
echo "⏱  $(date +%H%Mhrs)"
echo ""
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Finished to get status the datahub cluster  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"


;;


*)
		echo "Invalid value for action. refer usage"
                display_usage 
		;;
esac
