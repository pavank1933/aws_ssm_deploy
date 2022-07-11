#!/bin/bash -x
bash -ex <<-"RUNSCRIPT"
    # Install Ansible
    sudo su
    echo ">>>>>>>>>>>>>>>>>>>>>>> Installing Ansible Helper Scripts >>>>>>>>>>>>>>>>>>>>>>>"
    yum install python3 -y
    yum -y install python3-pip
    sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
    service sshd reload
    pip3 install ansible
    echo "export PATH=$PATH:/usr/local/bin" >> ~/.bashrc
    source ~/.bash_profile && export PATH
RUNSCRIPT