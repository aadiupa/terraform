variable "name" {
    type        = string
    default = null
}

variable "destination" {
  type = string
  default = null
}

variable "procesing_configuration_enabled" {
    type = bool
    default = disabled
}

variable "processor_type" {
    type = string
}

variable "ssm" {
    type = string
}

