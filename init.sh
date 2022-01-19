#!/bin/sh

NAMESPACE=mizotakhteh
SERVICE_ACCOUNT_NAME=github

## Initiate kubernetes namespace and create service account
kubectl apply -k kubernetes/overlays/homesys

## TODO: Deploy mproduct certification

## Get secret name
SECRET_NAME=$SERVICE_ACCOUNT_NAME-token

## Get token
TOKEN=$(kubectl get secret -n $NAMESPACE $SECRET_NAME -o jsonpath='{.data.token}')

# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
# Clear the color after that
clear='\033[0m'
#echo -e "The color is: ${red}red${clear}!"
#echo -e "The color is: ${green}green${clear}!"

## Print encrypted token
printf "Encrypted Token:\n$TOKEN\n"

## Print token
printf "${green}GH_SA_TOKEN:\n$(echo $TOKEN | base64 -d)${clear}\n"
