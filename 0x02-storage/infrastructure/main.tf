# infrastructure/main.tf

resource "aws_vpc" "staging_vpc" {
  cidr_block = var.vpc_cidr_block
  tags       = var.vpc_tags
}

resource "aws_subnet" "default_subnet_1" {
  vpc_id            = aws_vpc.staging_vpc.id
  cidr_block        = var.subnet_cidr_blocks[0]
  availability_zone = var.az_one_a
}

resource "aws_subnet" "default_subnet_2" {
  vpc_id            = aws_vpc.staging_vpc.id
  cidr_block        = var.subnet_cidr_blocks[1]
  availability_zone = var.az_one_b
}


resource "aws_security_group" "rds_security_group" {
  vpc_id      = aws_vpc.staging_vpc.id
  name        = "RDS Security Group"
  description = "Allow Mysql Ingress and all egress"

  ingress {
    description = "Open up 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.rds_sg_tags
}

resource "aws_security_group" "web_server_sg" {
  vpc_id      = aws_vpc.staging_vpc.id
  name        = "Web Server"
  description = "Allow HTTPS and SSH"

  ingress {
    description = "Open up 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Open up 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.web_sg_tags
}


resource "aws_db_subnet_group" "subnet_groups" {
  name        = "db-subnet"
  description = "Subnets for database instance"
  subnet_ids  = [aws_subnet.default_subnet_1.id, aws_subnet.default_subnet_2.id]

  tags = {
    "Name" : "Database subnets"
  }

}

resource "aws_db_instance" "database" {
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  multi_az               = true
  identifier             = var.db_name_identifier
  username               = var.db_user_name
  password               = var.db_password
  instance_class         = var.instance_class
  db_subnet_group_name   = aws_db_subnet_group.subnet_groups.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  availability_zone      = var.az_one_a
  db_name                = var.db_name
  skip_final_snapshot    = true
}
