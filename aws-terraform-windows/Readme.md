terraform script for windows provision in aws


Requirements

Ubuntu

    Reference: 
        
        https://www.terraform.io/downloads.html


    $ wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
    $ unzip terraform_0.13.5_linux_amd64.zip
    $ sudo mv terraform /usr/local/bin



    1. Terraform version
    2. terraform init
    3. terraform plan -var-file=config.tfvars
    4. terraform apply -var-file=config.tfvars
    5. terraform destroy -var-file=config.tfvars