terraform {
  backend "s3" {
    bucket = "octopus-terraform-releasetour"
    key    = "releasetour.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "example" {
  ami = "ami-04a0ee204b44cc91a"

  subnet_id                   = "${var.aws-subnet-id}"
  vpc_security_group_ids      = ["${var.aws-vpc-security-group-id}"]
  instance_type               = "${var.aws-instance-type}"
  key_name                    = "${var.aws-security-key-name}"
  associate_public_ip_address = true
  monitoring                  = true
  user_data                   = "${file("bootstrap.ps1")}"

  root_block_device {
    volume_size           = 128
    delete_on_termination = true
  }

  tags {
    Name = "OctopusTerraformDeployment"
    OwnerContact = "Arnav"
  }

}

variable "aws-subnet-id" {}
variable "aws-vpc-security-group-id" {}
variable "aws-instance-type" {}
variable "aws-security-key-name" {}