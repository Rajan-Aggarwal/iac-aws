###
# A very simple terraform script to deploy 
# multiple ec2 instances on aws
###

resource "aws_instance" "simple_instance" {
  # ubuntu 18.04 t2.micro free tier
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  count = "${length(var.instances)}"

  tags {
    Name = "simple_instance"
    Owner = "raaggarw"
    Env = "Practice"
  } 
}

# output on completion
# output all the running instances' AMI ID
# and instance types
output "Instance AMI ID:" {
  value = "${aws_instance.simple_instance.*.ami}"
}

output "Instance type" {
  value = "${aws_instance.simple_instance.*.instance_type}"
}

