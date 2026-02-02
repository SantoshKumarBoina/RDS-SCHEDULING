resource "aws_cloudwatch_event_rule" "start_rds" {
  name                = "${var.application_name}-${var.environment}-gitlab-rds-start"
  schedule_expression = "cron(30 03 ? * MON-FRI *)"  #Change accordingy as per your client requirements
}

resource "aws_cloudwatch_event_rule" "stop_rds" {
  name                = "${var.application_name}-${var.environment}-gitlab-rds-stop"
  schedule_expression = "cron(00 20 ? * MON-FRI *)"  #Change accordingy as per your client requirements
}