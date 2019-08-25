###
# EC2 instance and its ip address
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

resource "aws_security_group" "allow_ssh" {
  # to access ec2 instances from our terminal
  name = "allow-ssh"
  description = "Allow all inbound SSH connections"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_outbound" {
  # to install dependencies
  name = "allow-all-outbound"
  description = "Allow all outbound traffic"

  egress {
    # any
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "simple-instance" {
  # Ubuntu 18.04 AMI; t2.micro (free-tier)
  ami = "${data.aws_ami.ubuntu-1804.id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.ruby_key.key_name}"

  security_groups = [
    "${aws_security_group.allow_ssh.name}",
    "${aws_security_group.allow_outbound.name}",
  ]

  # metadata

  tags = {
      Name = "Simple Instance"
      Owner = "raaggarw"
      Env = "Practice"
  }
}

# Elastic ip address
resource "aws_eip" "simple-instance-ip" {
  instance = "${aws_instance.simple-instance.id}"
  vpc = true
}

