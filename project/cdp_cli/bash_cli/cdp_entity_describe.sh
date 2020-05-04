#!/bin/bash 
source $(cd $(dirname $0); pwd -L)/common.sh

 display_usage() { 
	echo "
Usage:
    $(basename "$0") <entity_type> <entity_name> (optional) <atribute_name> [--help or -h]

Description:
    Describe the given entity type. By default it shows "all" attribute. 

Arguments:
    arg_1: Entity type. valid options are : datalakes|dl , environments|env, datahub|dh
    arg_2: Entity Name
    arg_2: [Optional] Atribute type. Default atribute is "all". "

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

if [  $# -gt 2 ] 
then 
    echo "Too many arguments!"  >&2
    display_usage
    exit 1
fi 



#Env variables
env_variables
prefix=cdp


entity_type=`echo ${1}| tr '[:upper:]' '[:lower:]'`
entity_name=`echo ${2}| tr '[:upper:]' '[:lower:]'`



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

${CDP_PATH}/cdp datalake describe-datalake --datalake-name $entity_name
result=$?
handle_exception $? "$prefix" "datalake list" "$result"
;;

environments|environment|env)


${CDP_PATH}/cdp environments  describe-environment --environment-name $entity_name 
result=$?
handle_exception $? "$prefix" "datalake list" "$result"


;;


datahubs|datahb|dh)


${CDP_PATH}/cdp datahub describe-cluster --cluster-name $entity_name
result=$?
handle_exception $? "$prefix" "datalake list" "$result"




;;

dwh|datawarehouse|datawarehouses)

echo "┃Datawarehouse APIs are not exposed as of 04/2020. Please check in few months ┃"



;;



*)
		echo "Invalid value for action. refer usage"
                display_usage 
		;;
esac
