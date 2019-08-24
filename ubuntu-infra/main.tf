###
# A very simple terraform script to deploy 
# multiple ec2 instances on aws
###


# discover an appropriate AWS AMI for an ubuntu server

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

# random availability zone

resource "random_shuffle" "random_az" {
  input = ["a", "b", "c"]
  result_count = 1
}


# create the instance

resource "aws_instance" "ubuntu" {
  # ubuntu 18.04 t2.micro free tier
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  count = "${var.count}"
  associate_public_ip_address = "${var.ip_address}"
  availability_zone = "${random_shuffle.random_az.result}" 

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

# elastic ip address

resource "aws_eip" "ubuntu_ip" {
  instance = "${aws_instance.ubuntu.id}"
  vpc = true
}

# output on completion
# output all the running instances' AMI ID
# and instance types

output "Instance name" {
  value = "${aws_instance.ubuntu.*.tags.Name}"
}

output "Instance AMI ID:" {
  value = "${aws_instance.ubuntu.*.ami}"
}

output "Instance type" {
  value = "${aws_instance.ubuntu.*.instance_type}"
}

output "Instance region" {
  value = "${aws_instance.ubuntu.tags.Region}"
}

output "Instance az" {
  value = "${aws_instance.ubuntu.*.availability_zone}"
}

output "Ip address" {
  value = "${aws_eip.ubuntu_ip.public_ip}"
}
