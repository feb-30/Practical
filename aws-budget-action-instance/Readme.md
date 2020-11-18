terraform script for create budget action in aws

Instance tagname

    Name = demo

Requirement Packages

    1. terraform
    2  Awscli

Ubuntu

    $ wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
    $ unzip terraform_0.13.5_linux_amd64.zip
    $ sudo mv terraform /usr/local/bin

    $ sudo apt install python3-pip awscli -y

configure aws credentials

    $ aws configure

Reference: 
        
    https://www.terraform.io/downloads.html

Alerts:

   60% trigger warning mail to customer
   70% trigger warning mail to customer
   80% trigger warning mail to customer
   90% trigger warning mail and stop the ec2 instance

variables:

    accessKey     = ""
    secretKey     = ""
    region        = "eu-west-1"
    budgetName    = "Ec2MonthlyBudgets"
    tagName       = "Name"
    tagValue      = "demo"
    limit_unit    = "USD"
    limit_amount  = "100"
    budget_type   = "COST"
    ActionSubType = "STOP_EC2_INSTANCES"
    time_period_start = "2020-11-01_00:00"
    time_period_end   = "2087-06-15_00:00"
    timeUnit      = "MONTHLY"
    subscriber_email_addresses = "jinojoe@gmail.com"

commands

    1. terraform version
    2. terraform init
    3. terraform plan    -var-file=6-config.tfvars
    4. terraform apply   -var-file=6-config.tfvars
    5. terraform destroy -var-file=6-config.tfvars


Reference

    # aws budgets create-budget --account-id 1234567891234 --budget 'BudgetName=costaBudget,BudgetLimit={Amount=500,Unit=USD},TimeUnit=MONTHLY,BudgetType=COST'
    
    # aws budgets create-budget-action --account-id 1234567891234 --budget-name costaBudget --notification-type ACTUAL --action-type RUN_SSM_DOCUMENTS --action-threshold ActionThresholdValue=80,ActionThresholdType=PERCENTAGE --definition "SsmActionDefinition={ActionSubType=STOP_EC2_INSTANCES,Region=us-east-1,InstanceIds=[i-06381489d20000000,i-0e629146500000000]}" --execution-role-arn arn:aws:iam::1234567891234:role/MyBudgetRole --approval-model AUTOMATIC --subscribers SubscriptionType=EMAIL,Address=costa@costaemails.com 
    
    # https://docs.aws.amazon.com/cli/latest/reference/budgets/create-budget-action.html