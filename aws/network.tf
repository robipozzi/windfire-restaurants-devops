# Start - AWS VPC
resource "aws_vpc" "robi-vpc" {
  cidr_block            = "${var.vpcCIDRblock}"
  instance_tenancy      = "${var.instanceTenancy}"
  enable_dns_support    = "${var.dnsSupport}"
  enable_dns_hostnames  = "${var.dnsHostNames}"
  tags = {
    Name = "var.vpc['tag']"
  }
}
# Create the Subnet
resource "aws_subnet" "robi-subnet1" {
  vpc_id = "${aws_vpc.robi-vpc.id}"
  cidr_block = "${var.subnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone = "${var.availabilityZone}"
}
# Create VPC Network access control list
resource "aws_network_acl" "robi-vpc-acl" {
  vpc_id = "${aws_vpc.robi-vpc.id}"
  subnet_ids = [ "${aws_subnet.robi-subnet1.id}" ]
  # allow port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 22
    to_port    = 22
  }
  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 1024
    to_port    = 65535
  }
  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 1024
    to_port    = 65535
  }
}
# Create the Security Group
resource "aws_security_group" "robi-vpc-security-group" {
  vpc_id       = "${aws_vpc.robi-vpc.id}"
  name = "var.security-group['name']"
  description = "var.security-group['description']"
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
}
# Create the Internet Gateway
resource "aws_internet_gateway" "robi-vpc-gw" {
  vpc_id = "${aws_vpc.robi-vpc.id}"
}
# Create the Route Table
resource "aws_route_table" "robi-vpc-route-table" {
  vpc_id = "${aws_vpc.robi-vpc.id}"
}
# Create the Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = "${aws_route_table.robi-vpc-route-table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.robi-vpc-gw.id}"
}
# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = "${aws_subnet.robi-subnet1.id}"
  route_table_id = "${aws_route_table.robi-vpc-route-table.id}"
}
# End - AWS VPC