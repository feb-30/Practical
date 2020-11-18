data "aws_instance" "ec2" {
  filter {
    name   = "tag:${var.tagName}"
    values = [var.tagValue]
  }
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "aws budgets create-budget-action --account-id ${aws_budgets_budget.ec2.account_id} --budget-name ${aws_budgets_budget.ec2.name} --notification-type ACTUAL --action-type RUN_SSM_DOCUMENTS --action-threshold ActionThresholdValue=85,ActionThresholdType=PERCENTAGE --definition SsmActionDefinition={ActionSubType=${var.ActionSubType},Region=${var.region},InstanceIds=[${data.aws_instance.ec2.id}]} --execution-role-arn ${aws_iam_role.test_role.arn} --approval-model AUTOMATIC --subscribers SubscriptionType=EMAIL,Address=${var.subscriber_email_addresses}"
  }
  depends_on = [aws_iam_role_policy_attachment.test-attach, aws_budgets_budget.ec2]
}