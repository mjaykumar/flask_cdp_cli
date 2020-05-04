#!/bin/bash 
source $(cd $(dirname $0); pwd -L)/common.sh

 display_usage() { 
	echo "
Usage:
    $(basename "$0")  <environment_name> <workspace_name> (optional) <atribute_name> [--help or -h]

Description:
    Describe the given ML workspace type in given environment. By default it shows "all" attribute. 

Arguments:
    arg_1: The  environment  for  the  workspace  to describe
    arg_2: The name of the workspace to describe.
    arg_2: [Optional] Atribute type. Default atribute is "status". "

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



#Env variables
env_variables
prefix=cdp


env_name=${1}
ws_name=${2}



# Parsing arguments
#parse_parameters ${1} ${2}
#echo "${CHECK_MARK}  parameters parsed from ${1}"

# Running pre-req checks
#run_pre_checks
#echo "${CHECK_MARK}  pre-checks done"
#echo ""



${CDP_PATH}/cdp ml describe-workspace --environment-name $env_name --workspace-name $ws_name
result=$?
handle_exception $? "$prefix" "ml workspace list" "$result"


