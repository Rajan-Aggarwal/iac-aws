resource "aws_security_group" "allow_ssh" {
  # to access ec2 instances from our terminal
  name = "allow-ssh"
  description = "Allow all inbound SSH connections"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_outbound" {
  # to install dependencies
  name = "allow-all-outbound"
  description = "Allow all outbound traffic"

  egress {
    # any
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



