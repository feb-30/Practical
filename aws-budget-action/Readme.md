terraform script for create budget action in aws

Requirements

Ubuntu

    $ wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
    $ unzip terraform_0.13.5_linux_amd64.zip
    $ sudo mv terraform /usr/local/bin

Reference: 
        
    https://www.terraform.io/downloads.html

variables:

    accessKey                  =""
    secretKey                  =""
    region                     ="eu-west-1"
    budgetName                 ="Ec2MonthlyBudget"
    subscriber_email_addresses = "jinojoe@gmail.com"

commands

    1. terraform version
    2. terraform init
    3. terraform plan    -var-file=config.tfvars
    4. terraform apply   -var-file=config.tfvars
    5. terraform destroy -var-file=config.tfvars


Reference

    # aws budgets create-budget --account-id 1234567891234 --budget 'BudgetName=costaBudget,BudgetLimit={Amount=500,Unit=USD},TimeUnit=MONTHLY,BudgetType=COST'
    
    # aws budgets create-budget-action --account-id 1234567891234 --budget-name costaBudget --notification-type ACTUAL --action-type RUN_SSM_DOCUMENTS --action-threshold ActionThresholdValue=80,ActionThresholdType=PERCENTAGE --definition "SsmActionDefinition={ActionSubType=STOP_EC2_INSTANCES,Region=us-east-1,InstanceIds=[i-06381489d20000000,i-0e629146500000000]}" --execution-role-arn arn:aws:iam::1234567891234:role/MyBudgetRole --approval-model AUTOMATIC --subscribers SubscriptionType=EMAIL,Address=costa@costaemails.com 
    # https://docs.aws.amazon.com/cli/latest/reference/budgets/create-budget-action.html