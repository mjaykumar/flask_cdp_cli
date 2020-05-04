#!/bin/bash 
source $(cd $(dirname $0); pwd -L)/common.sh

 display_usage() { 
	echo "
Usage:
    $(basename "$0") <entity_type> [--help or -h]

Description:
    List all the instances of given entity type

Arguments:
    arg_1: Datalake action type. valid options are : datalakes|dl , environments|env, datahub|dh, ml                               "

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
prefix=cdp


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
echo "┃ Datalakes are  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
for val in $result; do
    echo $val
done
;;

environments|environment|env)

result=$(${CDP_PATH}/cdp environments  list-environments | jq -r '.environments[]."environmentName"')
handle_exception $? "$prefix" "environment list" "$result"
echo "┃ Environments are ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
for val in $result; do
    echo $val
done
;;


datahubs|datahb|dh)

result=$(${CDP_PATH}/cdp datahub list-clusters | jq -r '.clusters[]."clusterName"')
handle_exception $? "$prefix" "datahub cluster list" "$result"
echo "┃ Datahub Clusters are ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
for val in $result; do
    echo $val
done



;;

ml|ML)

env=$(${CDP_PATH}/cdp ml list-workspaces | jq -r '.workspaces[]."environmentName"')
handle_exception $? "$prefix" "ml Environment list" "$env"
echo "┃ ML Environment are ┃"
echo "┗━━━━━━━━━━━━━━━━━━━┛"
for val in $env; do
    echo $val
done
ws=$(${CDP_PATH}/cdp ml list-workspaces | jq -r '.workspaces[]."instanceName"')
handle_exception $? "$prefix" "ml workspace list" "$ws"
echo "┃ ML Workspaces are ┃"
echo "┗━━━━━━━━━━━━━━━━━━━┛"
for val in $ws; do
    echo $val
done
ws_crn=$(${CDP_PATH}/cdp ml list-workspaces | jq -r '.workspaces[]."crn"')
handle_exception $? "$prefix" "ml workspace list" "$ws_crn"
echo "┃ ML Workspaces CRN are ┃"
echo "┗━━━━━━━━━━━━━━━━━━━┛"
for val in $ws_crn; do
    echo $val
done
ws_status=$(${CDP_PATH}/cdp ml list-workspaces | jq -r '.workspaces[]."instanceStatus"')
handle_exception $? "$prefix" "ml workspace list" "$ws_status"
echo "┃ ML Workspaces instance status are ┃"
echo "┗━━━━━━━━━━━━━━━━━━━┛"
for val in $ws_status; do
    echo $val
done
k8_cluster_name=$(${CDP_PATH}/cdp ml list-workspaces | jq -r '.workspaces[]."k8sClusterName"')
handle_exception $? "$prefix" "ml workspace list" "$k8_cluster_name"
echo "┃ ML Workspaces kubernetes cluster are ┃"
echo "┗━━━━━━━━━━━━━━━━━━━┛"
for val in $k8_cluster_name; do
    echo $val
done


;;
dwh|datawarehouse|datawarehouses)

echo "┃Datawarehouse APIs are not exposed as of 04/2020. Please check in few months ┃"



;;



*)
		echo "Invalid value for action. refer usage"
                display_usage 
		;;
esac
