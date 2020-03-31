variable "aws_access_key" { }
variable "aws_secret_key" { }
variable "aws_region" {
  description = "One of us-east-2, us-east-1, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, us-west-2, eu-central-1, eu-west-1, eu-west-2, eu-west-2, eu-north-1, sa-east-1"
  default  = "eu-central-1"
}
variable "availabilityZone" {
  default = "eu-central-1a"
}
# AWS Network configuration variables - start
variable "vpc" {
  description = "Virtual Private Cloud definition"
  default = "windfire-vpc"
  #tags     = "Windfire VPC"
}
variable "frontendSubnet" {
  default = "windfire-frontend-subnet1"
  #tags    = "Windfire frontend subnet 1"
}
variable "backendSubnet" {
  default = "windfire-backend-subnet1"
  #tags    = "Windfire backend subnet 1"
}
variable "vpc-acl" {
  default = "windfire-acl"
  #tags    = "Windfire ACL"
}
variable "frontend-security-group" {
  description = "Frontend Security Group"
  default     = "windfire-securitygroup"
  #tags        = "Windfire Security Group"
}
variable "internet-gateway" {
  default = "windfire-igw"
  #tags    = "Windfire Internet Gateway"
}
variable "public-routetable" {
  default = "windfire-routetable"
  #tags    = "Windfire Route Table"
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
variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}
variable "frontendSubnetCIDRblock" {
  default = "10.0.1.0/24"
}
variable "backendSubnetCIDRblock" {
  default = "10.0.2.0/24"
}
variable "allIPsCIDRblock" {
  default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
  default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
  default = true
}
# AWS Network configuration variables - end
variable "ssh_user" {
  default = "ec2-user"
  description = "Most Ubuntu AMIs use Ubuntu as the default user. Normally safe to leave"
}
variable "bootstrap_script" {
  default = "bootstrap.sh"
  description = ""
}
variable "bootstrap_script_dest_dir" {
  default = "/tmp"
  description = ""
}