###
# All stdout outputs
###

output "server-ip" {
  value = "${aws_eip.simple-instance-ip.public_ip}"
}

output "server-ami-id" {
  value = "${aws_instance.simple-instance.ami}"
}
