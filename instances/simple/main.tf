resource "aws_instance" "simple_instance" {
  # ubuntu 18.04 t2.micro free tier
  ami = "ami-009110a2bf8d7dd0a"
  instance_type = "t2.micro"

  tags {
    Name = "simple_instance"
    Owner = "raaggarw"
    Env = "Practice"
  } 
}
