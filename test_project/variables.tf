variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = ["10.0.1.0/24" , "10.0.2.0/24"]
}

variable "availability_z" {
  default = ["ap-south-1a", "ap-south-1b"]
}
