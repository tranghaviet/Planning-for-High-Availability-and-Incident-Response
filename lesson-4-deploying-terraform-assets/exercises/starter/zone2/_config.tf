terraform {
   backend "s3" {
     bucket = "udacity-tf-tranghv-1"
     key    = "terraform/terraform.tfstate"
     region = "us-east-1"
   }
 }

 provider "aws" {
   region = "us-east-1"
   #profile = "default"

   default_tags {
     tags = local.tags
   }
 }
