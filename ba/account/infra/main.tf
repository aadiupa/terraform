# resource "null_resource" "cluster" {
#   # Won't do anything
  
#   }

module "dynamodb" {
   source = "../../modules/dynamodb"

   environment = var.environment
   creating = true
   name = "usersTable"
   hash_key = "orgId"
   write_capacity = 1 #use ssm
   read_capacity = 1 #use ssm
   range_key = "clientName"

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
     hash_key           = "orgId",
     name               = "orgId_clientId",
     projection_type    = "ALL",
     range_key          = "clientId",
     read_capacity      = 1, //need to use ssm
     write_capacity     = 1 // need to use ssm
     }]


}

# module "kinesis_stream" {
#   source = "../../modules/kinesis_stream"
  
#   name = "aditya"
#   shard_count = 1
#   iam_role_name = "kinesis_role"
#   iam_iam_role_policy_name = "kinesis_policy"

# }


#   global_secondary_indexes = [{
#      hash_key           = "Gametitle2",
#      name               = "aditya",
#      non_key_attributes = ["asdf","sdf"],
#      projection_type    = "INCLUDE",
#      range_key          = "GameTitleIndex2",
#      read_capacity      = 1, //prod non prod diff
#      write_capacity     = 1 // same as above
#      }]

#   attributes = [{
#         name = "Gametitle2",
#         type = "S"
#         },
#         {
#          name = "GameTitleIndex2",
#          type = "S"
#         },
#         {
#             name = "lock"
#             type = "S"
#         }
#     ]
