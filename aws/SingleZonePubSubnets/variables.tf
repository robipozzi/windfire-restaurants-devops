variable "aws_access_key" { }
variable "aws_secret_key" { }
variable "source_ip" { }
variable "aws_region" {
  default  = "eu-central-1"
  description = "One of us-east-2, us-east-1, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, us-west-2, eu-central-1, eu-west-1, eu-west-2, eu-west-2, eu-north-1, sa-east-1"
}
variable "availabilityZone" {
  default = "eu-central-1a"
}
###################################################################################
################### Start - AWS Network configuration variables ###################
###################################################################################
variable "vpc" {
  type = "string"
  default = "Windfire Virtual Private Cloud"
}
variable "subnet" {
  type = "map"
  default = {
    "frontend" = "Windfire Frontend subnet 1"
    "backend" = "Windfire Backend subnet 1"
    "bastion" = "Windfire Bastion subnet "
  }
}
variable "acl" {
  type = "map"
  default = {
    "vpc" = "Windfire VPC ACL"
    "public" = "Windfire Public ACL"
    "private" = "Windfire Private ACL"
    "bastion" = "Windfire Bastion ACL"
  }
}
variable "security-group" {
  type = "map"
  default = {
    "frontend" = "Windfire Frontend Security Group"
    "backend" = "Windfire Backend Security Group"
    "bastion" = "Windfire Bastion Security Group"
    "management" = "Windfire Management Security Group"
  }
}
variable "internet-gateway" {
  type = "string"
  default = "Windfire Internet Gateway"
}
variable "routetable" {
  type = "map"
  default = {
    "public" = "Windfire Public Route Table"
  }
}
variable "instanceTenancy" {
  default = "default"
}
variable "dnsSupport" {
  default = true
}
variable "dnsHostNames" {
  default = true
}
variable "cidr" {
  type = "map"
  default = {
    "vpc" = "10.0.0.0/16"
    "frontend" = "10.0.1.0/24"
    "backend" = "10.0.2.0/24"
    "bastion" = "10.0.0.0/24"
  }
}
variable "allIPsCIDRblock" {
  default = "0.0.0.0/0"
}
variable "mapPublicIP" {
  default = true
}
#################################################################################
################### End - AWS Network configuration variables ###################
#################################################################################
#=============================================================================
#================== Start - AWS EC2 configuration variables ==================
#=============================================================================
variable "key_name" {
  type = "string"
  default = "aws-key"
}
variable "ssh_user" {
  type = "string"
  default = "ec2-user"
}
variable "keypair" {
  type = "map"
  default = {
    "key_name" = "windfire-key"
    "publickey" = "windfire-key.pub"
  }
}
#===========================================================================
#================== End - AWS EC2 configuration variables ==================
#===========================================================================