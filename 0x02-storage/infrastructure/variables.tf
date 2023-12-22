variable "vpc_cidr_block" {
  type = string
  description = "VPC CIDR block"
  default = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  type = list(string)
  description = "Subnet CIDR block ranges"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "vpc_tags" {
  type = map(string)
  default = {
    "Name" : "Default VPC"
    "env"   = "staging"
    "owner" = "itsfoss0"
  }
}

variable "rds_sg_tags" {
  type = map(string)
  default = {
    "Name" : "RDS Security Group"
    "env"   = "staging"
    "owner" = "itsfoss0"
  }
}

variable "web_sg_tags" {
  type = map(string)
  default = {
    "Name" : "Web Server Security Group"
    "env"   = "staging"
    "owner" = "itsfoss0"
  }
}


variable "db_engine" {
  description = "Database engine (mysql)"
  type        = string
}

variable "db_name_identifier" {
  description = "DB instance identifier on the dashboard"
  type        = string
}

variable "db_user_name" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "application"
}
variable "instance_class" {
  description = "Database instance type"
  type        = string
}

variable "db_engine_version" {
  description = "MySQL version"
  type        = string
}

variable "allocated_storage" {
  description = "Needed storage"
  type        = number
}

variable "az_one_a" {
  type        = string
  description = "First Availability Zone"
  default     = "us-west-2a"
}

variable "az_one_b" {
  type        = string
  description = "Second availability Zone"
  default     = "us-west-2b"
}


## S3 storage
variable "s3_bucket_name" {
  type = string
  description = "S3 bucket name"
}

variable "s3_object_key" {
  type  = string
  description = "object key"
}

variable "s3_bucket_tags" {
    type = map(string)
    description = "S3 tags"
}