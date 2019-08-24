###
# EC2 instance and its ip address
###

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

