variable "default_region" {
  type = string
  description = "Default region for AWS"
  default = "us-west-2"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
}

variable "ami_id" {
  type = string
  default = "ami-0efcece6bed30fd98"
}
