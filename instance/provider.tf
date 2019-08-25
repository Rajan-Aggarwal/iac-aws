###
# provider info for aws access
###

provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}