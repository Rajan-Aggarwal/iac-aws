###
# track down our AMI
# because IDs may change
###

data "aws_ami" "ubuntu-18.04" {
  most_recent = true

  filter = {
      name = "name" # filter by name
      values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-18.04-amd64-server-*"]
  }

  filter = {
      name = "virtualization-type"
      values = ["hvm"]
  }

  owner = ["099720109477"] # aws canonical name
}
