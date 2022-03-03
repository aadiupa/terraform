resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
    name = var.name
    destination = var.destination
    extended_s3_configuration {
        role_arn   = aws_iam_role.firehose_role.arn
        bucket_arn = aws_s3_bucket.bucket.arn

        #get the data from datasources in main.tf
        processing_configuration {
            enabled = var.procesing_configuration_enabled

            processors {
                type = var.processor_type
                    parameters {
                        parameter_name  = var.ssm #need to fetch from ssm
                        parameter_value = "need to get this from data source but this will be after that"
        }
      }
    }
  }
}
    
