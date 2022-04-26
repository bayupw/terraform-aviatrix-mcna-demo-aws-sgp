terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63"
    }
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "~>2.21.2"
    }
  }
}

provider "aws" {
  alias  = "singapore"
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}

provider "google" {
  project = "bwibowo-01"
  region  = "australia-southeast1"
}