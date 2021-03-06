source ../../setenv.sh

###### Variable section - START
SCRIPT=provision.sh
WORKING_DIR=$PWD
AWS_ACCESS_KEY=$1
AWS_SECRET_KEY=$2
HELP_FLAG=0
TERRAFORM_MODE=apply
###### Variable section - END

###############
## printHelp ##
###############
printHelp()
{
    if [ "$HELP_FLAG" != "1" ]; then
        printf "${red}Missing arguments !!!${end}\n"
    fi
	printf "\n${yel}Usage:${end}\n"
  	printf "${cyn}$SCRIPT <AWS_ACCESS_KEY> <AWS_SECRET_KEY> [OPTIONS]${end}\n"
	printf "${cyn}where OPTIONS include:${end}\n"
	printf "${cyn}	-h Print this help message to the output stream${end}\n"
    printf "${cyn}	-f Full stack provisioning ${end}\n"
	printf "${cyn}	-p Generate and show Terraform execution plan without applying it${end}\n"
    printf "${cyn}	-d Destroy Terraform-managed infrastructure${end}\n"
}

####################
## Run Terraform  ##
####################
runTerraform()
{
	echo "######################################################"
	echo "############## Run Terraform automation ##############"
	echo "######################################################"
    
    SOURCE_IP=$(curl ipecho.net/plain ; echo)
    export TF_VAR_source_ip=$SOURCE_IP/32
    export TF_VAR_aws_access_key=$AWS_ACCESS_KEY
    export TF_VAR_aws_secret_key=$AWS_SECRET_KEY
	case $TERRAFORM_MODE in
        plan )	    echo ${cyn}Generating and showing Terraform plan ...${end}
                    terraform plan
			        ;;
        apply )	    applyTerraform
                    ;;
        fullstack ) echo ${cyn}Running Full stack deployment automation ...${end}
                    applyTerraform
                    echo ${cyn}Windfire Restaurants UI microservice deployment automation ...${end}
                    cd ../../../windfire-restaurants-ui/
                    ./deploy.sh 3 $AWS_ACCESS_KEY $AWS_SECRET_KEY
                    echo ${cyn}Windfire Restaurants Backend microservice deployment automation ...${end}
                    cd $WORKING_DIR
                    cd ../../../windfire-restaurants-node/
                    ./deploy.sh 2 $AWS_ACCESS_KEY $AWS_SECRET_KEY
                    ;;
        destroy )	echo ${cyn}Destroying Terraform managed infrastructure ...${end}
                    terraform destroy -auto-approve
                    ;;
    esac
}

applyTerraform()
{
    echo ${cyn}Running Terraform to build or change infrastructure ...${end}
    terraform apply -auto-approve
    echo "Bastion Host IP   =" ${cyn}$(terraform output bastion-public_ip)${end}
    echo "Bastion Hostname  =" ${cyn}$(terraform output bastion-public_dns)${end}
}

# ##############################################
# #################### MAIN ####################
# ##############################################
# ************ START evaluate args ************"
while [ "$1" != "" ]; do
    case $1 in
        -f )    TERRAFORM_MODE=fullstack
                ;;
        -p )    TERRAFORM_MODE=plan
                ;;
        -d )    TERRAFORM_MODE=destroy
                ;;
        -h )    HELP_FLAG=1
                printHelp
                exit
                ;;
    esac
    shift
done
# ************** END evaluate args **************"
if [ -z $AWS_ACCESS_KEY ] || [ -z $AWS_SECRET_KEY ]; then 
	printHelp
else
	RUN_FUNCTION=runTerraform
	$RUN_FUNCTION
fi