
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
    count = var.create ? length(var.targets) : 0

    rule = aws_cloudwatch_event_rule.main.0.name

    arn         = lookup(var.targets[count.index], "arn", null)
    target_id   = lookup(var.targets[count.index], "target_id", null)

    dynamic "input_transformer" {
        for_each = lookup(var.targets[count.index], "input_transformer", [])
        content {
            input_paths     = lookup(input_transformer.value, "input_paths", null )
            input_template  = lookup(input_transformer.value, "input_template", null)
        }
    }

    depends_on = [ aws_cloudwatch_event_rule.main, var.depends_modules ]
}
