resource "aws_cloudwatch_event_target" "start_target" {
  rule = aws_cloudwatch_event_rule.start_rds.name
  arn  = aws_lambda_function.gitlab_rds_scheduler.arn

  input = jsonencode({
    ACTION = "start"
  })
}

resource "aws_cloudwatch_event_target" "stop_target" {
  rule = aws_cloudwatch_event_rule.stop_rds.name
  arn  = aws_lambda_function.gitlab_rds_scheduler.arn

  input = jsonencode({
    ACTION = "stop"
  })
}