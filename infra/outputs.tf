/**
* Output these values to STDOUT
**/

output "Instance name" {
  description = "Name of the aws instance"
  value = "${aws_instance.ubuntu.*.tags.Name}"
}

output "Instance AMI ID:" {
  description = "AMI identifier of the aws instance recieved after applying the filter"
  value = "${aws_instance.ubuntu.*.ami}"
}

output "Instance type" {
  value = "${aws_instance.ubuntu.*.instance_type}"
}

output "Instance region" {
  value = "${aws_instance.ubuntu.*.tags.Region}"
}

output "Instance az" {
  value = "${aws_instance.ubuntu.*.availability_zone}"
}

output "Ip address" {
  value = "${aws_eip.ubuntu_ip.public_ip}"
}

output "Security group" {
  value = "${aws_instance.ubuntu.*.security_groups}"
}

output "EBS id and name" {
  value = "${aws_ebs_volume.ubuntu_volume.id}-${aws_ebs_volume.ubuntu_volume.tags.Name}"
}
