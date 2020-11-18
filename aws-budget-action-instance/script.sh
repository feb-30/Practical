#!/bin/bash

sleep 10

# CommandLine => Reference
export instanceIds=$(aws ec2 describe-instances --filters "Name=tag:$7,Values=$8"  --query "Reservations[*].Instances[*].[InstanceId]" --region=eu-west-1 --output text | paste -s -d, -)

# aws budgets create-budget-action --account-id ${aws_budgets_budget.ec2.account_id} \
    # --budget-name ${aws_budgets_budget.ec2.name} \
    # --notification-type ACTUAL \
    # --action-type RUN_SSM_DOCUMENTS \ 
    # --action-threshold ActionThresholdValue=85,ActionThresholdType=PERCENTAGE \
    # --definition "SsmActionDefinition={ActionSubType=${var.ActionSubType},Region=${var.region},InstanceIds=[${data.aws_instances.ec2.ids}]}" \ 
    # --execution-role-arn ${aws_iam_role.test_role.arn} \
    # --approval-model AUTOMATIC \
    # --subscribers SubscriptionType=EMAIL,Address=${var.subscriber_email_addresses}

# CommandLine => Reference

aws budgets create-budget-action --account-id $1 --budget-name $2 --notification-type ACTUAL --action-type RUN_SSM_DOCUMENTS --action-threshold ActionThresholdValue=85,ActionThresholdType=PERCENTAGE --definition "SsmActionDefinition={ActionSubType=$3,Region=$4,InstanceIds=[$instanceIds]}" --execution-role-arn $5 --approval-model AUTOMATIC --subscribers SubscriptionType=EMAIL,Address=$6

# Arguments => Reference

# $1 = ${aws_budgets_budget.ec2.account_id}
# $2 = ${aws_budgets_budget.ec2.name}
# $3 = ${var.ActionSubType}
# $4 = ${var.region}
# $5 = ${aws_iam_role.test_role.arn}
# $6 = ${var.subscriber_email_addresses}
# $7 = ${var.tagName}
# $8 = ${var.tagValue}