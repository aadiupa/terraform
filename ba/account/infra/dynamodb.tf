resource "aws_dynamodb_table" "users-table" {
    name           = "first"
    billing_mode   = "PROVISIONED"
    read_capacity  = 1
    write_capacity = 1
    hash_key = "orgId"
    range_key = "clientName"
    attribute {
        name = "orgId"
        type = "S"
    }
    
    attribute {
        name = "clientName"
        type = "S"
    }

    attribute {
        name = "clientId"
        type = "S"
    }

    ttl {
    attribute_name = "expireAt"
    enabled        = true
  }

    global_secondary_index {
    name               = "orgId_clientId"
    hash_key           = "orgId"
    range_key          = "clientId"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }
 # tags = var.default_tags
}