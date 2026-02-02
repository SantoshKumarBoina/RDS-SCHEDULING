data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lamda_function/lamda.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "gitlab_rds_scheduler" {
  function_name = "${var.application_name}-${var.environment}-gitlab-rds-scheduler"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  handler = "lamda.lambda_handler"
  runtime = "python3.12"
  role   = aws_iam_role.rds_scheduler_role.arn
  timeout = 60

  environment {
    variables = {
      RDS_IDENTIFIER = aws_db_instance.gitlab.identifier
      SNS_TOPIC_ARN  = aws_sns_topic.rds_scheduler_topic.arn
    }
  }
}