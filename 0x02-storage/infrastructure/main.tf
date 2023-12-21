resource "aws_default_vpc" "default_vpc" {
    # tags = var.vpc_tags
}

data "aws_availability_zones" "available_zones" {
  
}

resource "aws_default_subnet" "default_subnet_1" {
    availability_zone = data.aws_availability_zones.available_zones.names[0]
}

resource "aws_default_subnet" "default_subnet_2" {
    availability_zone = data.aws_availability_zones.available_zones.names[1]
}

resource "aws_security_group" "rds_security_group" {
    vpc_id = aws_default_vpc.default_vpc.id
    name = "RDS Security Group"
    description = "Allow Mysql Ingress and all egress"

    ingress  {
        description = "Open up 3306"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = var.rds_sg_tags
}

resource "aws_security_group" "web_server_sg" {
    vpc_id = aws_default_vpc.default_vpc.id
    name = "Web Server"
    description = "Allow HTTPS and SSH"

    ingress  {
        description = "Open up 443"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress  {
        description = "Open up 22"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    
    tags = var.web_sg_tags
}


resource "aws_db_subnet_group" "subnet_groups" {
    name = "db-subnet"
    description = "Subnets for database instance"
    subnet_ids = [aws_default_subnet.default_subnet_1.id, aws_default_subnet.default_subnet_2.id]

    tags  = {
        "Name": "Database subnets"
    }

}

resource "aws_db_instance" "database" {
    engine = var.db_engine
    engine_version = var.db_engine_version
    multi_az = true
    identifier = var.db_name_identifier
    username = var.db_user_name
    password = var.db_password
    instance_class = var.instance_class
    db_subnet_group_name = aws_db_subnet_group.subnet_groups.name
    vpc_security_group_ids = [aws_security_group.rds_security_group.id]
    availability_zone = "us-west-2a"
    db_name = "application"
    skip_final_snapshot = true
}