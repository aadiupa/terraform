resource "aws_iam_role" "role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service =  [
                    "lambda.amazonaws.com",
                    "events.amazonaws.com"
                ]
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "role_policy" {
  name = var.iam_iam_role_policy_name
  role = aws_iam_role.role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kinesis:PutRecord",
        ]
        Effect   = "Allow"
        Resource = aws_kinesis_stream.stream.arn
      },
    ]
  })
}