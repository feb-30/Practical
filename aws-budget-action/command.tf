resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "aws budgets create-budget-action --account-id 1234567891234 --budget-name costaBudget --notification-type ACTUAL --action-type RUN_SSM_DOCUMENTS --action-threshold ActionThresholdValue=80,ActionThresholdType=PERCENTAGE --definition "SsmActionDefinition={ActionSubType=STOP_EC2_INSTANCES,Region=us-east-1,InstanceIds=[i-06381489d20000000,i-0e629146500000000]}" --execution-role-arn arn:aws:iam::1234567891234:role/MyBudgetRole --approval-model AUTOMATIC --subscribers SubscriptionType=EMAIL,Address=costa@costaemails.com"
  }
}