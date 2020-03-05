# Terraform for AWS
The following files and scripts are provided Terraform experimentations with AWS:
* *run.sh* - this script runs Terraform configurations. It actually runs Terraform *Infrastructure as Code* configurations against AWS and requires 2 parameters:
    * AWS API KEY: this is the API Key ID which needs to be generated through AWS IAM service and associated with an AWS User
    * AWS API SECRET: this is the API Secret associated with the API Key
* *aws.tf* - it defines the AWS provider used by all other Terraform configurations
* *network.tf* - this Terraform configuration defines a Virtual Private Cloud and all related Network objects, allowing the creation of the following configuration in AWS:
    * 1 VPC                 - it defines a VPC within an established AWS region (by default is 'eu-central-1')
    * 1 Subnet              - it is defined within the above VPC
    * 1 ACL                 - it defines ACL rules for the VPC
    * 1 Security Group      - it defines a Security Group associated with the VPC 
    * 1 Internet Gateway    - it defines an Internet Gateway to allow egress to the Internet
    * 1 Route Table         - it defines a Route Table and associates it with the Subnet
* *variables.tf* - this file externalizes all the variables used by Terraform configurations