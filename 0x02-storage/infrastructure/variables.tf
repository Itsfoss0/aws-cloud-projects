variable "vpc_tags" {
  type = map(string)
  default = {
    "Name": "Default VPC"
    "env" = "staging"
    "owner" = "itsfoss0"
  }
}

variable "rds_sg_tags" {
  type = map(string)
  default = {
    "Name": "RDS Security Group"
    "env" = "staging"
    "owner" = "itsfoss0"
  }
}

variable "web_sg_tags" {
  type = map(string)
  default = {
    "Name": "Web Server Security Group"
    "env" = "staging"
    "owner" = "itsfoss0"
  }
}


variable "db_engine" {
  description = "Database engine (mysql)"
  type = string
}

variable "db_name_identifier" {
  description = "DB instance identifier on the dashboard"
  type = string
}

variable "db_user_name" {
  description = "Database username"
  type = string
}

variable "db_password" {
  description = "Database master password"
  type = string
}

variable "instance_class" {
  description = "Database instance type"
  type = string
}

variable "db_engine_version" {
  description = "MySQL version"
  type = string
}

variable "allocated_storage" {
  description = "Needed storage"
  type = number
}