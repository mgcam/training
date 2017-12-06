#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-fcc4db98
#
# Your subnet ID is:
#
#     subnet-fd3241b0
#
# Your security group ID is:
#
#     sg-a2c975ca
#
# Your Identity is:
#
#     terraform-training-pigeon
#

variable "aws_access_key" {
  type    = "string"
}

variable "aws_secret_key" {
  type    = "string"
}

variable "aws_region" {
  type    = "string"
  default = "eu-west-2"
}

terraform {
  backend "atlas" {
    name = "mgcam/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  count                  = "2"
  ami                    = "ami-fcc4db98"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-a2c975ca"]
  subnet_id              = "subnet-fd3241b0"
  tags {
    "Identity" = "terraform-training-pigeon"
    "Owner"    = "Marina"
    "Left"     = "Andrew"
    "Right"    = "Jaime"
    "Name"     = "web ${count.index + 1}/2"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
