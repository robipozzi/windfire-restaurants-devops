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
  default = "robi-vpc"
  tags     = "Robi VPC"
}
variable "subnet" {
  default = "robi-subnet1"
  tags    = "Robi VPC Subnet 1"
}
variable "security-group" {
  description = "Robi VPC Security Group"
  default     = "robi-vpc-security-group"
  tags        = "Robi VPC Security Group"
}
variable "vpc-acl" {
  default = "robi-vpc-acl"
  tags    = "Robi VPC ACL"
}
variable "internet-gateway" {
  default = "robi-vpc-gw"
  tags    = "Robi VPC Internet Gateway"
}
variable "route-table" {
  default = "robi-vpc-route-table"
  tags    = "Robi VPC Route Table"
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
variable "subnetCIDRblock" {
  default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {
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