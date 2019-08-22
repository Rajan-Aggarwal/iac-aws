#!/bin/bash

##########################

# bash script to apply/run
# the terraform scripts

##########################

# export path variable to opt
# opt stores the terraform executable

export PATH=$PATH:/opt

# input parsing assertions

if [[ -z "$1" ]]; then
  echo ""
  echo "Invalid syntax"
  echo "Usage: ./apply.sh <PATH>"
  echo ""
  exit
fi

# initialize terraform 

terraform init $1

# download and/or update modules from the root

terraform get $1

# to apply the infrastructure creation plan

terraform apply --auto-approve $1