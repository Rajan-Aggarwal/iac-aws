###
# key pair for ssh connection to the instance
###

resource "aws_key_pair" "ruby_key" {
  key_name = "ruby_key"
  public_key = "${file("/home/rajan/ruby_key.pub.pub")}"
}
