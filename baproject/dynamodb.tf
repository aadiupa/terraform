provider "aws" {
  region = "us-east-2"
}


resource "aws_dynamodb_table" "basic-dynamodb-table" {
    name           = data.aws_ssm_parameter.name.value
    billing_mode   = "PROVISIONED"
    read_capacity  = 1
    write_capacity = 1
    hash_key = "id"
    attribute {
        name = "id"
        type = "S"
    }

    ttl {
    attribute_name = "expireAt"
    enabled        = true
  }
 # tags = var.default_tags
}


data "aws_ssm_parameter" "name" {
    name="/alignx/dynamodb/tablename"
}