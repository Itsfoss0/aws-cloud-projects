resource "aws_vpc" "web_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "WebVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "PublicSubnet"
    Role = "Public"
  }

}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "PrivateSubnet"
    Role = "Private"
  }

}


resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "ProdIGW"
  }

}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "ProdRouteTables"
  }
}


resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id

}

resource "aws_key_pair" "sshkey" {
  key_name   = "dev-ssh-key"
  public_key = var.sshkey

}

resource "aws_security_group" "webserver-sg" {
  name        = "WebServerSG"
  description = "Web server Security Group to allow HTTP and SSH"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow inbound HTTP traffic"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP Traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "WebServerSG"
  }
}
resource "aws_instance" "server" {
  ami                    =  var.ami_id
  key_name               = aws_key_pair.sshkey.key_name
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("user-data-nginx-dev.sh")

  tags = {
    Name      = "Server"
    Terraform = "True"
  }
}

