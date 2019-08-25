/**
* Authentication for the cloud provider
**/

provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}
