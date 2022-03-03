resource "aws_dynamodb_table" "this" {
  count            = var.create_dynamodb ? 1 : 0
  name             = var.name
  billing_mode     = var.billing_mode
  hash_key         = var.hash_key
  range_key        = var.range_key
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  ttl {
    enabled        = var.ttl_enabled
    attribute_name = var.ttl_attribute_name
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes

    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes

    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      projection_type = global_secondary_index.value.projection_type
      range_key       = lookup(global_secondary_index.value, "range_key", null)
      read_capacity   = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity  = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "replica" {
    for_each = var.replica_regions

    content {
      region_name = replica.value.region_name
      kms_key_arn = lookup(replica.value, "kms_key_arn", null)
    }
  }

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.server_side_encryption_kms_key_arn
  }

  tags = merge(
    var.tags,
    {
      "STAGE" = format("%s", var.environment)
    },
  )

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
}


# Creating this resource in terraform and the same will be used in serverless, as this will be uploaded to SSM
resource "aws_ssm_parameter" "dynamodb_ssm" {
  count       = var.create_ssm_parameter ? 1 : 0
  name        = "/${var.environment}/dynamodb/${var.name}"
  description = "ARN for ${var.name} dynamodb"
  type        = "String"
  value       = concat(aws_dynamodb_table.this.*.arn, [""])[0]
}

resource "aws_ssm_parameter" "stream_view" {
  count       = var.create_ssm_stream_parameter ? 1 : 0
  name        = "/${var.environment}/dynamodb/${var.name}-stream"
  description = "ARN for ${var.name} dynamodb stream"
  type        = "String"
  value       = concat(aws_dynamodb_table.this.*.stream_arn, [""])[0]
}