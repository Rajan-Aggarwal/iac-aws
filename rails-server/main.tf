resource "aws_instance" "rails-instance" {
  # Ubuntu 18.04 AMI; t2.micro (free-tier)
  ami = "${data.aws_ami.ubuntu-1804.id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.ruby_key.key_name}"

  security_groups = [
    "${aws_security_group.allow_ssh.name}",
    "${aws_security_group.allow_outbound.name}",
  ]

  # install rails

  provisioner "remote-exec" {
    inline = [
      "command curl -sSL https://rvm.io/mpapis.asc | gpg --import -",
      "\\curl -sSL https://get.rvm.io | bash -s stable --rails",
    ]

    connection = {
      type = "ssh"
      user = "ubuntu" # default user in every aws ec2 instance
      private_key = "${file("/home/rajan/ruby_key.pub")}"
    }
  } 

  # metadata

  tags = {
      Name = "Rails instance"
      Owner = "raaggarw"
      Env = "Practice"
  }
}
