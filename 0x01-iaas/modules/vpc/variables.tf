variable "cidr_block" {
    type = string
    description = "CIDR block range for the VPC" 
}

variable "tags" {
    description = "Tags for the VPC"
    type = map(string)
}