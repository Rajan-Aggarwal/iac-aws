resource "aws_instance" "rails-instance" {
  # Ubuntu 18.04 AMI; t2.micro (free-tier)
  ami = "${data.aws_ami.ubuntu-18.04}"
  instance_type = "${var.instance_type}"

  security_groups = [
    "${aws_security_group.allow_ssh}",
    "${aws_security_group.allow_outbound}",
  ]

  tags = {
      Name = "Rails instance"
      Owner = "raaggarw"
      Env = "Practice"
  }
}
