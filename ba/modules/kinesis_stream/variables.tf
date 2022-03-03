variable "name" {
    type = string
    default = null
}

variable "shard_count" {
    default = 1
}

variable "retention_period" {
    default = 48
}

variable "stream_mode" {
    default = {}
}

variable "iam_role_name" {
    type = string
    default = null
}


variable "iam_iam_role_policy_name" {
    type = string
    default = null
}