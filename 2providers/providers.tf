provider "aws" {
  region                  = "ap-south-1"
  allowed_account_ids     = [612053565767]
}


provider "aws" {
  region = "eu-west-1"
  alias = "europe"
  allowed_account_ids     = [612053565767]
}
