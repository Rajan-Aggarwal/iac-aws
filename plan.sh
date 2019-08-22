#!/bin/bash

##########################

# bash script to plan (check for errors) 
# a terraform infrastructure

##########################

# export path variable to opt
# opt stores the terraform executable

export PATH=$PATH:/opt

# input parsing assertions

if [[ -z "$1" ]]; then
  echo ""
  echo "Invalid syntax"
  echo "Usage: ./plan.sh <PATH>"
  echo ""
  exit
fi

# initialize terraform 

terraform init $1

# download and/or update modules from the root

terraform get $1

# to recieve the infrastructure creation plan

terraform plan $1