resource "aws_instance" "simple_instance" {
  # ubuntu 18.04 t2.micro free tier
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  tags {
    Name = "simple_instance"
    Owner = "raaggarw"
    Env = "Practice"
  } 
}
