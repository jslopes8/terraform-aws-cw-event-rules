# Terraform module to AWS CloudWatch Event Rule

The code will provide the following features on AWS.
* [CloudWatch Event Rule](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html)
* [CloudWatch Event Target](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html)


## Usage
```hcl
module "cw_event_rule" {
    source  = "git@github.com:jslopes8/terraform-aws-cw-event-rules.git"

    name        = "test-cw"
    description = "CW Events Rules Monitor Organizations"

    add_targets = [
        {
            target  = "lambda"
            arn     = module.lambda.function_arn
        },
       {
            target  = "SendToSNS"
            arn     = module.sns_topic.sns_arn
        },
    ]

    event_pattern   = <<PATTERN
    {
        "source": [
            "aws.organizations"
        ],
        "detail-type": [
            "AWS API Call via CloudTrail"
        ],
        "detail": {
            "eventSource": [
                "organizations.amazonaws.com"
            ],
            "eventName": [
                "CreateAccount",
                "CreateOrganizationalUnit",
                "DeleteOrganizationalUnit"
            ]
        }
    }
    PATTERN

    default_tags    = {
        ApplicationRole = "CW Events Rules Monitor Organizations"
    }
}
```

## Requirements
| Name | Version |
| ---- | ------- |
| aws | ~> 2.68 |
| terraform | ~> 0.12 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Variables Inputs
| Name | Description | Required | Type | Default |
| ---- | ----------- | -------- | ---- | ------- |
| name | The rule's name. | `yes` | `string` | ` ` |
| description | The description of the rule. | `no` | `string` | `null` |
| add_targets | Key-value block you want to add targets to. | `yes` | `any` | ` ` |
| event_pattern | Event pattern described a JSON object. If schedule_expression isn't specified | `no` | `any` | ` ` |
| schedule_expression | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes) |  `no` | `string` | ` ` |
| role_arn | ARN associated with the role that is used for target invocation. | `yes` | `string` | ` ` |
| is_enabled | Whether the rule should be enabled | `no` | `string` | `true` |
| default_tags | Key-value map of tags to assign to the resource. | `no` | `map` | `{ }` |

## Variable Outputs
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
| Name | Description |
| ---- | ----------- |
| cw_arn | The Amazon Resource Name (ARN) of the rule. |