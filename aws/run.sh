source ../setenv.sh

###### Variable section - START
SCRIPT=run.sh
AWS_ACCESS_KEY=$1
AWS_SECRET_KEY=$2
###### Variable section - END

###############
## printHelp ##
###############
printHelp()
{
    printf "${red}Missing arguments !!!${end}\n"
	printf "\n${yel}Usage:${end}\n"
  	printf "${cyn}$SCRIPT <AWS_ACCESS_KEY> <AWS_SECRET_KEY>${end}\n"
}

####################
## Run Terraform  ##
####################
runTerraform()
{
	echo "######################################################"
	echo "############## Run Terraform automation ##############"
	echo "######################################################"
    echo ${cyn}Running Terraform plan ...${end}
    export TF_VAR_aws_access_key=$AWS_ACCESS_KEY
    export TF_VAR_aws_secret_key=$AWS_SECRET_KEY
    #terraform plan
    terraform apply
}

if [ -z $AWS_ACCESS_KEY ] || [ -z $AWS_SECRET_KEY ]; then 
	printHelp
else
	RUN_FUNCTION=runTerraform
	$RUN_FUNCTION
fi