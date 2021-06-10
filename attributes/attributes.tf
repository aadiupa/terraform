provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_s3_bucket" "s3bucket" {
    bucket = "aditya100301"
}


output "s3bucket" {
  value = "aws_s3_bucket.s3bucket.bucket_domain_name"
}

output "s3bucketregion" {
  value = "aws_s3_bucket.s3bucket.region"
}
