#!/bin/bash -x
bash -ex <<-"RUNSCRIPT"
    set -e
    sudo su
    # Install Helper tools
    echo ">>>>>>>>>>>>>>>>>>>>>>> Installing Helper tools >>>>>>>>>>>>>>>>>>>>>>>"
    yum update -y
    sudo amazon-linux-extras install epel -y
    #yum -y install unzip wget
    TERRAFORM_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk     '{$1=$1};1'`
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
    unzip terraform_${TERRAFORM_VER}_linux_amd64.zip
    mv terraform /usr/local/bin/
    echo "export PATH=$PATH:/usr/local/bin/" >> ~/.bashrc
    source ~/.bash_profile && export PATH
    rm -rf terraform_*
    yum install jq -y

    # Install Jenkins Helper Scripts
    echo ">>>>>>>>>>>>>>>>>>>>>>> Installing Jenkins Helper Scripts >>>>>>>>>>>>>>>>>>>>>>>"
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    yum -y upgrade
    yum install jenkins java-1.8.0-openjdk-devel -y sudo systemctl daemon-reload
    systemctl start jenkins
RUNSCRIPT