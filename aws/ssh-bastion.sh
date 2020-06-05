source ../setenv.sh

###### Variable section - START
FLAG=0
SCRIPT=ssh-bastion.sh
SSH_KEY=aws-key.pem
USER=ec2-user
BASTION_HOST_PUBLIC_IP=$1
HOST_PRIVATE_IP=$2
ARGS_NUMBER=$#
ARGS=$@
###### Variable section - END

###############
## printHelp ##
###############
printHelp()
{
    if [ "$FLAG" != "1" ]; then
        printf "${red}Missing arguments !!!${end}\n"
    fi
	printf "\n${yel}Usage:${end}\n"
  	printf "${cyn}$SCRIPT <BASTION_HOST_PUBLIC_IP> <HOST_PRIVATE_IP> [-k <SSH_KEY_PEM_FILE>] [-u <USER>]${end}\n"
}

###############################
## SSH through Bastion Host  ##
###############################
runSSH()
{
	echo "######################################################"
	echo "############## SSH through Bastion Host ##############"
	echo "######################################################"
    echo ${cyn}Adding $SSH_KEY ssh key to keychain ...${end}
    ssh-add -k $HOME/.ssh/$SSH_KEY
    SSH_COMMAND="ssh -J $USER@$BASTION_HOST_PUBLIC_IP $USER@$HOST_PRIVATE_IP"
    #ssh -i $HOME/.ssh/$SSH_KEY $USER@$HOST_PRIVATE_IP -o "proxycommand ssh -W %h:%p -i $HOME/.ssh/$SSH_KEY $USER@$BASTION_HOST_PUBLIC_I"
    echo ${cyn}ssh into target host through Bastion host ...${end}
    echo Using following command : ${cyn}$SSH_COMMAND ...${end}
    $SSH_COMMAND
}
# ##############################################
# #################### MAIN ####################
# ##############################################
# ************ START evaluate args ************"
while [ "$1" != "" ]; do
    case $1 in
        -k )    shift
                SSH_KEY=$1
                ;;
        -u )    shift
                USER=$1
                ;;
        -h )    FLAG=1
                printHelp
                exit
                ;;
    esac
    shift
done
# ************** END evaluate args **************"
if [ -z $BASTION_HOST_PUBLIC_IP ] || [ -z $HOST_PRIVATE_IP ]; then 
	printHelp
else
	RUN_FUNCTION=runSSH
	$RUN_FUNCTION
fi