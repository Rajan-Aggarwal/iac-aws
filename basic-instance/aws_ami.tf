###
# track down our AMI
# because IDs may change
###

data "aws_ami" "ubuntu-1804" {
  most_recent = true

  filter = {
      name = "name" # filter by name
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter = {
      name = "virtualization-type"
      values = ["hvm"]
  }

  owners = ["099720109477"] # aws canonical name
}
