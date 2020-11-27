terraform script for create lambda budget action in aws

tools:

    1. terraform

Instance tagname

    office-hours = ec-data-platform

Requirement Packages

    1. terraform

Ubuntu

    $ wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
    $ unzip terraform_0.13.5_linux_amd64.zip
    $ sudo mv terraform /usr/local/bin


Reference:

    https://www.terraform.io/downloads.html

Alerts:

    80%  Actual
    90%  Actual
    100% Forecasting
    100% Actual


variables:

    #accessKey     = ""
    #secretKey     = ""
    region         = "eu-west-1"
    lambdaname     = "lambda-aws-budget-action"
    budgetName     = "demobudgets"
    tagName        = "office-hours"
    tagValue       = "ec-data-platform"

commands

    1. terraform version
    2. terraform init
    3. terraform plan    -var-file=5-config.tfvars
    4. terraform apply   -var-file=5-config.tfvars
    5. terraform destroy -var-file=5-config.tfvars

Errors:
    
        lambda => python3.8 => boto3 => "'Budgets' object has no attribute 'create_budget_action'"

        Error throw:

        {
        "errorMessage": "'Budgets' object has no attribute 'create_budget_action'",
        "errorType": "AttributeError",
        "stackTrace": [
            "  File \"/var/task/main.py\", line 123, in lambda_handler\n    CreateBudgetAction(AccountId=ACCOUNT_ID,BudgetName=BUDGET_NAME, ExecutionRoleArn=ROLE, Region=REGION, Address=emailaddress[0])\n",
            "  File \"/var/task/main.py\", line 86, in CreateBudgetAction\n    client.create_budget_action(\n",
            "  File \"/var/runtime/botocore/client.py\", line 614, in __getattr__\n    raise AttributeError(\n"
        ]
        }