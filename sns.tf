resource "aws_sns_topic" "rds_scheduler_topic" {
  name = "${var.application_name}-${var.environment}-gitlab-rds-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.rds_scheduler_topic.arn
  protocol  = "email"
  endpoint  = var.notification_email
}