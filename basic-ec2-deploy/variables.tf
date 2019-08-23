###
# home of all variables
###

variable "owner" {
  default = "raaggarw"
  description = "Name of the owner of the aws account"
}


variable "region" {
  default = "ap-south-1"
  description = "The region/location of the data-center"
}

variable "profile" {
  default = "default"
  description = "AWS credentials profile as per user declaration"
}

variable "instance_name" {
  default = "ec2"
  description = "The name of the ec2 instance"
}


variable "ami_id" {
  default = "ami-009110a2bf8d7dd0a" # ubuntu 18.04 for ap-south-1
  description = "The image id for the ec2 instance image"
}

variable "instance_type" {
  default = "t2.micro" # free-tier 
  description = "The type of instance for the deployment"
}

variable count {
  default = "1"
  description = "Number of servers for deployment"
}

variable "volume_size" {
  default = "35"
}


variable "ip_address" {
  default = "true"
}

variable "project_name" {
  default = "ec2_deployment"
}

variable "environment" {
  default = "production"
}



