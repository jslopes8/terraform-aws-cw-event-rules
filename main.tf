resource "aws_cloudwatch_event_rule" "main" {
    count = var.create ? 1 : 0

    name                = var.name
    description         = var.description
    schedule_expression = var.schedule

    role_arn        = var.role_arn 
    is_enabled      = var.is_enabled
    tags            = var.default_tags

    event_pattern   = var.event_pattern
}
resource "aws_cloudwatch_event_target" "main" {
    depends_on = [ aws_cloudwatch_event_rule.main ]

    count   = var.create ? length(var.add_targets) : 0

    rule      = aws_cloudwatch_event_rule.main.0.name

    target_id = lookup(var.add_targets[count.index], "target", null)
    arn       = lookup(var.add_targets[count.index], "arn", null)

    
}