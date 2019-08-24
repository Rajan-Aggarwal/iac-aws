###
# A very simple terraform script to deploy 
# multiple ec2 instances on aws
###

data "aws_ami" "ubuntu" {
  most_recent = true

  filter = {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter = {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # aws canonical name
}

resource "aws_instance" "ubuntu" {
  # ubuntu 18.04 t2.micro free tier
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  count = "${var.count}"
  associate_public_ip_address = "${var.ip_address}"

  root_block_device {
    volume_size = "${var.volume_size}"
  }

  tags {
    Name = "ubuntu + ${count.index}"
    Region = "${var.region}"
    Count = "${count.index}"
    Timestamp = "${timestamp()}"
    Project = "${var.project_name}"
    Owner = "${var.owner}"
    Environment = "${var.environment}"
  } 
}

resource "aws_eip" "ubuntu_ip" {
  instance = "${aws_instance.ubuntu.id}"
  vpc = true
}


# output on completion
# output all the running instances' AMI ID
# and instance types
output "Instance AMI ID:" {
  value = "${aws_instance.ubuntu.*.ami}"
}

output "Instance type" {
  value = "${aws_instance.ubuntu.*.instance_type}"
}