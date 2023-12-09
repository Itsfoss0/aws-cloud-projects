terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }
  }
  backend "remote" {
    organization = "itsfoss0-aws-projects"
    workspaces {
      name = "dev-state"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
