terraform {
  backend "s3" {
    bucket = "first01982"
    key    = "tfstatefile.tfstate"
    region = "ap-south-1"
  }
}
