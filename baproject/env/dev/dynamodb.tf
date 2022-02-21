resource "aws_dynamodb_table" "basic-dynamodb-table" {
    name           = "EPS_dev"
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
