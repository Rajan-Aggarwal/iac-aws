###
# key pair for ssh connection to the instance
###

resource "aws_key_pair" "aws_ec2_key" {
  key_name = "aws_ec2_key"
  public_key = "${file("/home/rajan/aws_ec2_key.pub.pub")}"
}
