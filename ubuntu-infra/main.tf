/**
* A terraform script to build a robust infrastructure
* around a single ec2 instances
**/

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

# random availability zone generator

resource "random_shuffle" "random_az" {
  input = ["a", "b", "c"]
  result_count = 1
}

# security groups

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow all SSH inbound"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow all for now
  }

  tags {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_outbound" {
  name = "allow_outbound"
  description = "All all outbound connections"

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_outbound"
  }
}


# create the instance

resource "aws_instance" "ubuntu" {
  # ubuntu 18.04 t2.micro free tier
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  count = "${var.count}"
  associate_public_ip_address = "${var.ip_address}"
  availability_zone = "${var.region}${random_shuffle.random_az.result[0]}" 

  depends_on = [
    "aws_security_group.allow_outbound",
    "aws_security_group.allow_ssh"
  ]

  security_groups = [
    "${aws_security_group.allow_outbound.name}",
    "${aws_security_group.allow_ssh.name}"
  ]

  root_block_device {
    volume_size = "${var.volume_size}"
  }

  tags {
    Name = "ubuntu${count.index}"
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
  depends_on = ["aws_instance.ubuntu"]
  vpc = true
}
