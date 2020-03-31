# Start - AWS VPC
resource "aws_vpc" "windfire-vpc" {
  cidr_block = "${var.vpcCIDRblock}"
  instance_tenancy = "${var.instanceTenancy}"
  enable_dns_support = "${var.dnsSupport}"
  enable_dns_hostnames = "${var.dnsHostNames}"
  tags = {
    Name = "${var.vpc["tags"]}"
  }
}
# Create the Subnets
resource "aws_subnet" "windfire-frontend-subnet1" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  cidr_block = "${var.frontendSubnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone = "${var.availabilityZone}"
  tags = {
    Name = "${var.frontendSubnet["tags"]}"
  }
}
resource "aws_subnet" "windfire-backend-subnet1" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  cidr_block = "${var.backendSubnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone = "${var.availabilityZone}"
  tags = {
    Name = "${var.backendSubnet["tags"]}"
  }
}
# Create VPC Network access control list
resource "aws_network_acl" "windfire-frontend-acl" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  subnet_ids = [ "${aws_subnet.windfire-frontend-subnet1.id}" ]
  # allow HTTP port 80
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 80
    to_port    = 80
  }
  # allow SSH port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 22
    to_port    = 22
  }
  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "${var.vpc-acl["tags"]}"
  }
}
resource "aws_network_acl" "windfire-backend-acl" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  subnet_ids = [ "${aws_subnet.windfire-backend-subnet1.id}" ]
  # allow HTTP port 8080
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.vpcCIDRblock}"
    from_port  = 8080
    to_port    = 8080
  }
  # allow SSH port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 22
    to_port    = 22
  }
  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "${var.vpc-acl["tags"]}"
  }
}
# Create the Security Group
resource "aws_security_group" "windfire-frontend-securitygroup" {
  vpc_id       = "${aws_vpc.windfire-vpc.id}"
  name         = "${var.frontend-security-group["name"]}"
  description  = "${var.-frontendsecurity-group["description"]}"
  # allow HTTP port 80
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  # allow SSH port 22
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # allow egress ephemeral ports
  egress {
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 1024
    to_port    = 65535
    protocol   = "tcp"
  }
  tags = {
    Name = "${var.security-group["tags"]}"
  }
}
# Create the Internet Gateway
resource "aws_internet_gateway" "windfire-igw" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  tags = {
    Name = "${var.internet-gateway["tags"]}"
  }
}
# Create Route Tables
resource "aws_route_table" "windfire-public-routetable" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  tags = {
    Name = "${var.public-routetable["tags"]}"
  }
}
resource "aws_route_table" "windfire-private-routetable" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  tags = {
    Name = "${var.public-routetable["tags"]}"
  }
}
# Create the Internet Access
resource "aws_route" "windfire-internet-access" {
  route_table_id         = "${aws_route_table.windfire-public-routetable.id}"
  destination_cidr_block = "${var.allIPsCIDRblock}"
  gateway_id             = "${aws_internet_gateway.windfire-igw.id}"
}
# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = "${aws_subnet.windfire-frontend-subnet1.id}"
  route_table_id = "${aws_route_table.windfire-public-routetable.id}"
}
# End - AWS VPC