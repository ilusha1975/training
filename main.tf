#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-7e50c21a
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-bass
#
variable aws_access_key {
  default = "AKIAJZ3UFCT2IHY2QEPQ"
}

variable aws_secret_key {
  default = "a30QICTYapL9+KVsp9fKZ9o2s1+vNgxaafn1nPEg"
}

variable aws_region {
  type    = "string"
  default = "us-west-1"
}

variable "num_webs" {
	default = "1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7e50c21a"
  vpc_security_group_ids = ["sg-29ef374e"]

  tags = {
    Identity      = "autodesk-bass"
    SomeOtherTag  = "some other tag value"
    YetAnotherTag = "Whatever2"
    Name = "web ${count.index + 1}/${var.num_webs}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "tags" {
  value = ["${aws_instance.web.*.tags}"]
}

