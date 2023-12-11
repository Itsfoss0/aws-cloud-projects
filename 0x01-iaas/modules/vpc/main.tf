# VPC module 

resource "aws_vpc" "web_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}
