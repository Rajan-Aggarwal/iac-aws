/**
* Output these values to STDOUT
**/

output "Instance name" {
  value = "${aws_instance.server.*.tags.Name}"
}

output "Instance AMI ID:" {
  value = "${aws_instance.server.*.ami}"
}

output "Instance type" {
  value = "${aws_instance.server.*.instance_type}"
}

output "Instance az" {
  value = "${aws_instance.server.*.availability_zone}"
}

output "Ip address" {
  value = "${aws_eip.server_ip.*.public_ip}"
}

output "Security group" {
  value = "${aws_instance.server.*.security_groups}"
}

output "EBS id" {
  value = "${aws_ebs_volume.server_volume.*.id}"
}

output "EBS name" {
  value = "${aws_ebs_volume.server_volume.*.tags.Name}"
}

