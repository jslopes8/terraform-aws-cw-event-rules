output "cw_arn" {
    value = aws_cloudwatch_event_rule.main.0.arn
}