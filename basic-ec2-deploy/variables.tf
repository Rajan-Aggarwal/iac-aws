###
# home of all variables
###

variable "region" {
  default = "ap-south-1"
  description = "The region/location of the data-center"
}

variable "profile" {
  default = "default"
  description = "AWS credentials profile as per user declaration"
}

variable "ami_id" {
  default = "ami-009110a2bf8d7dd0a" # ubuntu 18.04 for ap-south-1
  description = "The image id for the ec2 instance image"
}

variable "instance_type" {
  default = "t2.micro" # free-tier 
  description = "The type of instance for the deployment"
}

variable "instances" {
  default = [
    "server0",
    "server1",
    "server2",
  ]
  description = "List of servers you want to boot"
}

