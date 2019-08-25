/**
* Output these values to STDOUT
**/

output "Instance name" {
  value = "${aws_instance.ubuntu.*.tags.Name}"
}

output "Instance AMI ID:" {
  value = "${aws_instance.ubuntu.*.ami}"
}

output "Instance type" {
  value = "${aws_instance.ubuntu.*.instance_type}"
}

output "Instance az" {
  value = "${aws_instance.ubuntu.*.availability_zone}"
}

output "Ip address" {
  value = "${aws_eip.ubuntu_ip.*.public_ip}"
}

output "Security group" {
  value = "${aws_instance.ubuntu.*.security_groups}"
}

output "EBS id" {
  value = "${aws_ebs_volume.ubuntu_volume.*.id}"
}

output "EBS name" {
  value = "${aws_ebs_volume.ubuntu_volume.*.tags.Name}"
}

