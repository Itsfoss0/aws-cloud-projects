resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "security_group" {
  name        = "Web Server SG"
  vpc_id      = aws_default_vpc.default_vpc.id
  description = "Allow HTTP, HTTPS and SSH inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Plain HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    description = "Allow all outbound traffic from instance"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web Server SG"
  }
}

resource "aws_instance" "server" {
  instance_type = var.ec2_instance_type
  ami           = var.ami_id
  key_name      = "web-server"
  user_data     = file("../user-data.sh")
  vpc_security_group_ids = [ aws_security_group.security_group.id ]

  tags = {
    "Name" = "Project Lamp Web Server",
    "Team" = "DevOps",
    "Env"  = "Staging"
  }
}
