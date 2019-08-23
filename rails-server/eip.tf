###
# An elastic ip address can be migated to other
# ec2 instances (fault-tolerance)
###

resource "aws_eip" "rails-server-ip" {
  instance = "${aws_instance.rails-instance.id}"
  vpc = true
}
