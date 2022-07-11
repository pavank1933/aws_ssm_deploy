#!/bin/bash

echo "TF installation only works for mac...Assuming as mac and proceeding..."

aws sts get-caller-identity --query Account --output text &>/dev/null

ret=$?
if [ $ret -ne 0 ]; then
        echo "AWS CLI creds not set... Exiting..."
        exit 1
else
        export AWS_DEFAULT_REGION="us-east-1"
        echo "AWS creds configured locally...Need to check wheter its configured for the AWS account '117843297914' "
fi

account_id=`aws sts get-caller-identity --query Account --output text`

if [ $account_id = "117843297914" ]
then
  echo "This is Accrete AWS 'Infrastructure-Dev' account(117843297914)...Proceeding with tools Infra creation..."
else
  echo "AWS CLI creds not set for Accrete AWS 'Infrastructure-Dev' account(117843297914)... Exiting..."
  exit 1
fi

tf_exists () {

### Install Terraform ###
echo "Installing Terraform..."

TERRAFORM_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk     '{$1=$1};1'`

wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip

unzip terraform_${TERRAFORM_VER}_linux_amd64.zip

mv terraform /usr/local/bin/

echo "export PATH=$PATH:/usr/local/bin/" >> ~/.bashrc

source ~/.bash_profile && export PATH

rm -rf terraform_*

}

tf_file=/usr/local/bin/terraform
if test -f "$tf_file"; then
    echo "$tf_file exists....Creating TF_STATE_BUCKET, Jenkins, Ansible INFRA"
else
    tf_exists
fi

### Create INFRA for TF-STATE-Bucket, DynamoDB in S3###
cd common/tf-state-config/tf-state-config-dev/us-east-2
echo "TF STATE BUCKET CREATING..."
terraform init
terraform plan -var-file="value.tfvars"
terraform apply -var-file="value.tfvars" -auto-approve

#/usr/local/bin/terraform init
#/usr/local/bin/terraform destroy -var-file="value.tfvars" -auto-approve

### Create INFRA for TF-STATE-Bucket in S3###
cd ../../../../common/tools/tools-dev/us-east-2/
echo "CREATING Jenkins INFRA...Ansible anyway handled by AWS SSM RunCommand"
terraform init
terraform plan -var-file="value.tfvars"
terraform apply -var-file="value.tfvars" -auto-approve

#/usr/local/bin/terraform init
#/usr/local/bin/terraform destroy -var-file="value.tfvars" -auto-approve

