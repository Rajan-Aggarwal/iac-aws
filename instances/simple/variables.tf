variable "region" {
  default = "ap-south-1"
  description = "The region of the data-center"
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


