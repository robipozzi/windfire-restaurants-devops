variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "aws_region" {
  default     = "eu-central-1"
  description = "One of us-east-2, us-east-1, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, us-west-2, eu-central-1, eu-west-1, eu-west-2, eu-west-2, eu-north-1, sa-east-1"
}

variable "availabilityZone" {
  default = "eu-central-1a"
}

###################################################################################
################### Start - AWS Network configuration variables ###################
###################################################################################
variable "vpc" {
  type    = string
  default = "Windfire Virtual Private Cloud"
}

variable "azs" {
  default = "2"
}

variable "subnet" {
  type = map(string)
  default = {
    "frontend" = "Windfire Frontend subnet"
    "backend"  = "Windfire Backend subnet"
    "bastion"  = "Windfire Bastion subnet"
    "public"   = "Windfire Public subnet"
  }
}

variable "acl" {
  type = map(string)
  default = {
    "vpc"     = "Windfire VPC ACL"
    "public"  = "Windfire Public ACL"
    "private" = "Windfire Private ACL"
    "bastion" = "Windfire Bastion ACL"
  }
}

variable "security-group" {
  type = map(string)
  default = {
    "alb"      = "Windfire ALN Security Group"
    "frontend" = "Windfire Frontend Security Group"
    "backend"  = "Windfire Backend Security Group"
    "bastion"  = "Windfire Bastion Security Group"
    "public"   = "Windfire Public Security Group"
  }
}

variable "internet-gateway" {
  type    = string
  default = "Windfire Internet Gateway"
}

variable "nat-gateway" {
  type    = string
  default = "Windfire NAT Gateway"
}

variable "routetable" {
  type = map(string)
  default = {
    "public"  = "Windfire Public Route Table"
    "private" = "Windfire Private Route Table"
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
  type = map(string)
  default = {
    "vpc"     = "10.0.0.0/16"
    "bastion" = "10.0.0.0/28"
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
variable "ami" {
  type    = string
  default = "ami-03ab4e8f1d88ce614"
}

variable "key_name" {
  type    = string
  default = "aws-key"
}

variable "ssh_user" {
  type    = string
  default = "ec2-user"
}

variable "keypair" {
  type = map(string)
  default = {
    "key_name"  = "windfire-aws-key"
    "publickey" = "windfire-aws-key.pub"
  }
}
#===========================================================================
#================== End - AWS EC2 configuration variables ==================
#===========================================================================