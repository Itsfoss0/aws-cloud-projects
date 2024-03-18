variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
}

variable "sshkey" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTl/fJgrBhiv7RCJmvmKYXR1lz9S1bT5KS0FTxm9sqLRHC1TDmj2Z0NfiLEj0QyH+DHvM75IPsq2PBCOFM6n3Pejv9unHNBcqju3EX6AK9GXafNgqCvsniWNsOZn6x/c93Ey1rlhXtDulmUG+QxjKj15Zgo7TzLRi/hSgeu7BsLrNa+T7G5CmkEKvSZIQZGLDhy/b6avUcEYg5eUu8pjwugIhDy13qiKNpgVWGllDzr9QhIhqtqntrrb9kxzmdhtL30MuHBRhYnaQzIE0yJuV+DLJUYizoBbMuZ0yE4BAFS2xCYUY3a3Q1J++xqgQCLbl0FkEBqgn7rzLgB4F4RLfFdCyyMeFixHHP1dEWeLVvHYAcvl3xlXGZ9y31BPw+rUr6l0ykBFr6qgt/9Zg9FQgdH8O6YmiZadIbqWf2nX3mx70jxJdEXwoI6nUYeNDzaqlacv/C6LcdZ3jil8EW9F1VrmixIG0tgdCCT9q3iADsCfDEYEH50amgNKOBMl0r6N0= itsfoss@itsfoss"

}

variable "ami_id" {
  type = string
  default = "ami-0efcece6bed30fd98"
}

# storage s3

variable "s3_tags" {
  description = "S3 tags"
  type = map(string)
  default = {
    "Name" = "Profile images storage"
    "Env" = "Production"
    "Owner" = "Itsfoss0"
  }

}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type = string
  default = "value"
}