resource "aws_budgets_budget" "ec2" {
  name              = var.budgetName
  budget_type       = "COST"
  limit_amount      = "0.1"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2020-11-01_00:00"
  time_unit         = "MONTHLY"

  cost_filters = {
    TagKeyValue = "key$demo"
  }

  cost_types {
    include_credit             = false
    include_discount           = false
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = true
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_blended                = false
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 85
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.subscriber_email_addresses]
  }
}




# create-budget-action  --account-id aws_budgets_budget.ec2.account_id --budget-name aws_budgets_budget.ec2.name
  --notification-type <value>
  --action-type <value>
  --action-threshold <value>
  --definition <value>
  --execution-role-arn <value>
  --approval-model <value>
  --subscribers <value>
  [--cli-input-json <value>]
  [--generate-cli-skeleton <value>]

# https://docs.aws.amazon.com/cli/latest/reference/budgets/create-budget-action.html