/**
* A terraform script to build a robust infrastructure
* around a single ec2 instances
**/

# discover an appropriate AWS AMI for an ubuntu server

data "aws_ami" "server_ami" {
  most_recent = true

  filter = {
    name = "name"
    values = "${var.ami-name-query}"
  }

  filter = {
    name = "virtualization-type"
    values = "${var.ami-vtype-query}"
  }

  owners = ["099720109477"] # aws canonical name
}

# random availability zone generator

resource "random_shuffle" "random_az" {
  input = ["${var.availability_zone_list}"]
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

# create the ssh key-pair

resource "aws_key_pair" "aws_key_pair_infra" {
  key_name = "aws_key"
  public_key = "${file("${var.ssh_public_key_file}")}"
}


# create the instance

resource "aws_instance" "server" {

  # if the user provides ami_id as a var, use it
  # otherwise use the default query (Ubuntu 18.04)
  ami = "${var.ami_id == "None" ? data.aws_ami.server_ami.id : var.ami_id}"

  instance_type = "${var.instance_type}"
  count = "${var.count}"
  availability_zone = "${var.region}${random_shuffle.random_az.result[0]}" 

  key_name = "${aws_key_pair.aws_key_pair_infra.key_name}"

  depends_on = [
    "aws_security_group.allow_outbound",
    "aws_security_group.allow_ssh"
  ]

  security_groups = [
    "${aws_security_group.allow_outbound.name}",
    "${aws_security_group.allow_ssh.name}"
  ]

  # root_block_device {
  #   volume_size = "${var.volume_size}"
  # }

  tags {
    Name = "${var.instance_name}${count.index}"
    Region = "${var.region}"
    Count = "${count.index}"
    Timestamp = "${timestamp()}"
    Project = "${var.project_name}"
    Owner = "${var.owner}"
    Environment = "${var.environment}"
  } 
}

# elastic ip address

resource "aws_eip" "server_ip" {
  count = "${aws_instance.server.count}"
  instance = "${aws_instance.server.*.id[count.index]}"
  depends_on = ["aws_instance.server"]
  vpc = true
}

# volume for the instance

resource "aws_ebs_volume" "server_volume" {
  count = "${aws_instance.server.count}"
  availability_zone = "${aws_instance.server.*.availability_zone[count.index]}"
  size = 10

  tags {
    Name = "ebs-${aws_instance.server.*.tags.Name[count.index]}"
  }

  depends_on = ["aws_instance.server"]
}

# attach the volume to the instance

resource "aws_volume_attachment" "attach_ebs" {
  count = "${aws_ebs_volume.server_volume.count}"
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.server_volume.*.id[count.index]}"
  instance_id = "${aws_instance.server.*.id[count.index]}"

  depends_on = [
    "aws_instance.server", 
    "aws_ebs_volume.server_volume"
  ]
}