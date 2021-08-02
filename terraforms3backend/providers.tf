provider "aws" {
  region                  = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
  allowed_account_ids     = [612053565767]
}
