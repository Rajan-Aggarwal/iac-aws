/**
* Home of all variables
*
* One can change these variables at runtime 
* using -var flag
* or using -varfile tag and making a variable file
* of the form variables.vtf
**/

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
  default = "10"
  description = "Volume of the ebs instance (in GB)"
}

variable "project_name" {
  default = "Ubuntu infrastructure builder"
  description = "Name of the project we are running the scripts for"
}

variable "environment" {
  default = "production"
  description = "We assume that this is a production environment"
}

variable "availability_zone_list" {
  type = "list"
  default = ["a", "b"]
  description = "Different regions have different number of AZs"
}

variable "ssh_public_key_file" {
  default = "/home/rajan/aws-keys/aws_key"
  description = "File where the ssh public key is stored"
}

variable "ssh_private_key_file" {
  default = "/home/rajan/aws-keys/aws_key.pub"
  description = "File where the ssh private key is stored"
}


