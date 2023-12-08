provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "server" {
  ami = "ami-093467ec28ae4fe03"
  instance_type = "t2.micro"

  tags = {
    Name = "Server"
    Terraform = "True"
  }
}