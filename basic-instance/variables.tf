###
# home of all variables
###

variable "region" {
  default = "ap-south-1"
  description = "region/location of cloud data-center"
}

variable "profile" {
  default = "default"
  description = "AWS authentication profile (~/.aws/credentials)"
}

variable "instance_type" {
  default = "t2.micro" # free-tier
  description = "Type of aws-ec2 instance to be deployed"
}

