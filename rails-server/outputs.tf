###
# All stdout outputs
###

output "server-ip" {
  value = "${aws_eip.rails-server-ip.public_ip}"
}

output "server-ami-id" {
  value = "${aws_instance.rails-instance.ami}"
}
