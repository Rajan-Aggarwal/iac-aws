/**
* Home of all variables
*
* One can change these variables at runtime 
* using -var-file tag and making a variable file
* of the form variables.tfvars
**/

variable "owner" {
  default = "raaggarw"
  description = "Name of the owner of the aws account"
}

variable "ami-name-query" {
  type = "list"
  default = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  description = "Query for name-based filter to find the required ami"
}

variable "ami-vtype-query" {
  type = "list"
  default = ["hvm"]
  description = "Query for virtualization type based filter to find the required ami"
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
  default = "ubuntu"
  description = "The name of the ec2 instance"
}

variable "ami_id" {
  default = "None" # ubuntu 18.04 for ap-south-1
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
  default = "AWS infrastructure"
  description = "Name of the project we are running the scripts for"
}

variable "environment" {
  default = "dev"
  description = "We assume that this is a production environment"
}

variable "availability_zone_list" {
  type = "list"
  default = ["a", "b"]
  description = "Different regions have different number of AZs"
}

variable "ssh_public_key_file" {
  default = "/home/rajan/aws_ec2_key.pub"
  description = "File where the ssh public key is stored"
}
