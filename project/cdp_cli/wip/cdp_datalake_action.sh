#!/bin/bash 
source $(cd $(dirname $0); pwd -L)/common.sh

 display_usage() { 
	echo "
Usage:
    $(basename "$0") <datalake_name> <datalake_action_type> [--help or -h]

Description:
    Performs the action against provided datalake name

Arguments:
    arg_1: Datalake action type. valid options are : describe, host-status, service-status,                               "

}


# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 


# Check the numbers of arguments
if [  $# -lt 1 ] 
then 
    echo "Not enough arguments!"  >&2
    display_usage
    exit 1
fi 

if [  $# -gt 1 ] 
then 
    echo "Too many arguments!"  >&2
    display_usage
    exit 1
fi 



#Env variables
env_variables


entity_type=`echo ${1}| tr '[:upper:]' '[:lower:]'`


# Parsing arguments
#parse_parameters ${1} ${2}
#echo "${CHECK_MARK}  parameters parsed from ${1}"

# Running pre-req checks
#run_pre_checks
#echo "${CHECK_MARK}  pre-checks done"
#echo ""



case ${entity_type} in

datalakes|datalake|dl)

# list

result=$(${CDP_PATH}/cdp datalake list-datalakes | jq -r '.datalakes[]."datalakeName"')
handle_exception $? "$prefix" "datalake list" "$result"
echo "┃ Dataakes are  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
for val in $result; do
    echo $val
done
;;

environments)

result=$(${CDP_PATH}/cdp environments  list-environments | jq -r '.environments[]."environmentName"' 2>&1 > /dev/null)
handle_exception $? "$prefix" "environment list" "$result"
echo "┃ Finished listing the environments ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
;;


datahub)

dl_status=$(${BASE_SCRIPT_DIR}/cdp_describe_dl.sh  $datalake_name | jq -r .datalake.status)
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
