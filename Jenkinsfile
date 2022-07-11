import com.cwctravel.hudson.plugins.extended_choice_parameter.ExtendedChoiceParameterDefinition
pipeline {
  options {
    disableConcurrentBuilds()
  }
  agent {
    node { 
        label 'master' 
        } 
    }
  stages 
  {
    stage('Infra, App Build and Deploy') 
    {
    steps 
        {
        script 
            {
             properties([
                parameters([
                        password(name: 'AWS_ACCESS_KEY_ID', description: ''), //With this params, Not need to explicity export AWS VARIABLES to work with AWS CLI
                        password(name: 'AWS_SECRET_ACCESS_KEY', description: ''),
                        password(name: 'AWS_SESSION_TOKEN', description: ''),
                        choice(name: 'AWS_REGION', choices: ['us-east-1', 'us-east-2'], description: 'AWS REGION'),
                        choice(name: 'AWS_INFRA_DEPLOY', choices: ['False', 'True'], description: ''),
                        choice(name: 'TF_ACTION', choices: ['Apply', 'Destroy'], description: 'if "AWS_INFRA_DEPLOY" is false, then no action(Apply/Destroy) works'),
                        choice(name: 'APP_DEPLOY', choices: ['False', 'True'], description: ''),
                        extendedChoice(  
                              multiSelectDelimiter: ',', 
                              name: 'ANSIBLE_ROLE', 
                              quoteValue: false, 
                              saveJSONParameterToFile: false, 
                              type: 'PT_CHECKBOX', 
                              value:'WEB,UI,DB',
                              defaultValue: 'false,false,false', 
                              description: 'if "APP_DEPLOY" is false, then no role(WEB,UI,DB) works else deploy roles on respective instances', 
                              visibleItemCount: 10),
                          ])
                       ])

            def WORKSPACE_DIR="${env.JOB_NAME}".replaceAll('/','_')
            
            echo "Git Branch : ${env.GIT_BRANCH} and Jenkins WORKSPACE_DIR: ${WORKSPACE_DIR}"

            switch(env.GIT_BRANCH) {
                case "master":
                  props = readProperties file: 'properties/deploy-dev.properties'
                  break
                case "feature1_tools":
                  props = readProperties file: 'properties/deploy-dev.properties'
                  break
                default:
                  props = "NONE"
                  echo("This is FEATURE branch and props:${props}.....Merge FEATURE branch with DEV/MASTER branch and re-run to deploy INFRA/APPS")
                  if(props == "NONE"){
                    currentBuild.result = 'SUCCESS'
                    return
                  }
              }
            
            echo "PROPS DATA: ${props}"
            
            if (params.AWS_INFRA_DEPLOY == 'True' && params.TF_ACTION == 'Apply') {
               sh '''
                   #!/bin/bash
                   #Stops scripts if any below command fails
                   set -e

                   exit 1

                   ## Declare multi path
                   tf_path="/var/lib/jenkins/workspace/''' +WORKSPACE_DIR+ '''/Terraform/vibe/"
                   declare -a arr=("security/security-dev/us-east-2/" "vibe-network/vibe-dev/us-east-2/" "external-clients/external-clients-dev/us-east-2/" "external-services/external-services-dev/us-east-2/" "internal-services/internal-services-dev/us-east-2/" "databases/databases-dev/us-east-2/")
                  
                   ## Apply Infra Loop
                   for vibe_path in "${arr[@]}"
                   do
                      echo "TF PATH: $tf_path$vibe_path.....Apply Infra...."
                      cd $tf_path$vibe_path
                      /usr/local/bin/terraform init
                      /usr/local/bin/terraform plan -var-file="value.tfvars"
                      /usr/local/bin/terraform apply -var-file="value.tfvars" -auto-approve
                   done
                  '''
              }
              else if(params.AWS_INFRA_DEPLOY == 'True' && params.TF_ACTION == 'Destroy')
              {
                sh '''#!/bin/bash
                      #Stops scripts if any below command fails
                      set -e

                      exit 1

                      ## Declare multi path 
                      tf_path="/var/lib/jenkins/workspace/''' +WORKSPACE_DIR+ '''/Terraform/vibe/"
                      declare -a arr=("databases/databases-dev/us-east-2/" "external-clients/external-clients-dev/us-east-2/" "external-services/external-services-dev/us-east-2/" "internal-services/internal-services-dev/us-east-2/" "security/security-dev/us-east-2/" "vibe-network/vibe-dev/us-east-2/")
                      
                      ## Destroy Infra Loop
                      for vibe_path in "${arr[@]}"
                      do
                         echo "TF PATH: $tf_path$vibe_path.....Destroying Infra...."
                         cd $tf_path$vibe_path
                         /usr/local/bin/terraform init
                         /usr/local/bin/terraform destroy -var-file="value.tfvars" -auto-approve
                      done
                   '''
              }
              else{
                echo "No infra changes using Terraform..."
              }
              if (params.APP_DEPLOY == 'True') {
                  echo "Starting APP_DEPLOY using Ansible..."
                  //Ansible Stuff here
                  echo "Ansible Roles Selected: "+ params.ANSIBLE_ROLE
                  sh '''
                     aws s3 cp /var/lib/jenkins/workspace/''' +WORKSPACE_DIR+ '''/ansible/ s3://ansible-code/ --recursive
                    '''
                  def role_list = params.ANSIBLE_ROLE.split(',')
                  role_list.each { role ->
                      echo "Deploying Ansible Roles on the following ${role} instances"
                      sh '''#!/bin/bash
                          #Stops scripts if any below command fails
                          set -e
                          echo "Deploying Ansible Role: ${role}"

                          ###pre-requisite: AWS SSM should be installed and configured on AWS instances. Amazonlinux2 comes with SSM default. AWS ssm role should be attached to instances
                          if [[ ''' +role+ ''' == "WEB" ]];
                          then
                              inst_list=`aws ec2 describe-instances --filters 'Name=tag:role,Values=*''' +role+ '''*' --query 'Reservations[*].Instances[*].{InstanceId:InstanceId}[0].InstanceId' --region ''' +params.AWS_REGION+ ''' --output text | sed -e 's/\\s\\+/,/g'`
                              echo "WEB Instances are: ${inst_list}"
                              ./scripts/ssm_cli.sh ''' +params.AWS_REGION+ ''' $inst_list web.yml
                          elif [[ ''' +role+ ''' == "UI" ]];
                          then
                              inst_list=`aws ec2 describe-instances --filters 'Name=tag:role,Values=*''' +role+ '''*' --query 'Reservations[*].Instances[*].{InstanceId:InstanceId}[0].InstanceId' --region ''' +params.AWS_REGION+ ''' --output text | sed -e 's/\\s\\+/,/g'`
                              echo "UI Instances are: ${inst_list}"
                              ./scripts/ssm_cli.sh ''' +params.AWS_REGION+ ''' $inst_list ui.yml
                          elif [[ ''' +role+ ''' == "DB" ]];
                          then
                              inst_list=`aws ec2 describe-instances --filters 'Name=tag:role,Values=*''' +role+ '''*' --query 'Reservations[*].Instances[*].{InstanceId:InstanceId}[0].InstanceId' --region ''' +params.AWS_REGION+ ''' --output text | sed -e 's/\\s\\+/,/g'`
                              echo "DB Instances are: ${inst_list}"
                              ./scripts/ssm_cli.sh ''' +params.AWS_REGION+ ''' $inst_list db.yml
                          else
                              echo "Something wrong with ansible roles"
                              exit 1
                          fi
                      '''
                  }
                  echo "APP DEPLOY DONE..."
              }
              else{
                echo "No Apps to deploy..."
              }
           }
        }
     }
   }
}
