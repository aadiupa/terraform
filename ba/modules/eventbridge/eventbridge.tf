resource "aws_cloudwatch_event_bus" "messenger" {
  name = var.eventbridgename
}

output "eventbus_arn" {
  value = aws_cloudwatch_event_bus.messenger.arn
}