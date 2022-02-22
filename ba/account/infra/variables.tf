variable "aws_region" {
  default = "us-east-2"
}


variable "bucket_enabled" {
  type        = bool
  default     = true
  description = "Whether to create the s3 bucket."
}