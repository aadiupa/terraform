module "dynamodb" {
  source = "../../modules/dynamodb"

  environment          = var.environment
  create_dynamodb      = true
  create_ssm_parameter = false
  name                 = "client-secrets-${var.environment}"
  hash_key             = "orgId"
  write_capacity       = 1 #use ssm
  read_capacity        = 1 #use ssm
  range_key            = "clientName"

  attributes = [
    {
      name = "orgId",
      type = "S"
    },
    {
      name = "clientName"
      type = "S"
    },
    {
      name = "clientId"
      type = "S"
    }
  ]

  global_secondary_indexes = [{
    hash_key        = "orgId",
    name            = "orgId_clientId",
    projection_type = "ALL",
    range_key       = "clientId",
    read_capacity   = 1, //need to use ssm
    write_capacity  = 1  // need to use ssm
  }]

}

