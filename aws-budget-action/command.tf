resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "aws budgets create-budget-action --account-id ${aws_budgets_budget.ec2.account_id} --budget-name ${aws_budgets_budget.ec2.name} --notification-type ACTUAL --action-type RUN_SSM_DOCUMENTS --action-threshold ActionThresholdValue=85,ActionThresholdType=PERCENTAGE --definition SsmActionDefinition={ActionSubType=STOP_EC2_INSTANCES,Region=${var.region},InstanceIds=[i-06381489d20000000,i-0e629146500000000]} --execution-role-arn ${aws_iam_role.test_role.arn} --approval-model AUTOMATIC --subscribers SubscriptionType=EMAIL,Address=${var.subscriber_email_addresses}"
  }
  # dependsOn = [aws_budgets_budget.ec2, aws_iam_role.test_role]
}