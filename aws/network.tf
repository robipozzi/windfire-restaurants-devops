#######################################################
################### Start - AWS VPC ###################
#######################################################
resource "aws_vpc" "windfire-vpc" {
  cidr_block = "${var.cidr["vpc"]}"
  instance_tenancy = "${var.instanceTenancy}"
  enable_dns_support = "${var.dnsSupport}"
  enable_dns_hostnames = "${var.dnsHostNames}"
  tags = {
    Name = "${var.vpc}"
  }
}
# Create Internet Gateway
resource "aws_internet_gateway" "windfire-igw" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  tags = {
    Name = "${var.internet-gateway}"
  }
}
# Create NAT Gateway
resource "aws_eip" "windfire-nat-eip" {
  vpc = true
}
resource "aws_nat_gateway" "windfire-ngw" {
  allocation_id = "${aws_eip.windfire-nat-eip.id}"
  subnet_id = "${aws_subnet.windfire-frontend-subnet1.id}"
  tags = {
    Name = "${var.nat-gateway}"
  }
  depends_on = ["aws_internet_gateway.windfire-igw"]
}
# Create Route Tables
resource "aws_route_table" "windfire-public-route" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  tags = {
    Name = "${var.routetable["public"]}"
  }
}
resource "aws_route_table" "windfire-private-route" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  tags = {
    Name = "${var.routetable["private"]}"
  }
}
# Create Internet route access
resource "aws_route" "windfire-internet-route" {
  route_table_id = "${aws_route_table.windfire-public-route.id}"
  destination_cidr_block = "${var.allIPsCIDRblock}"
  gateway_id = "${aws_internet_gateway.windfire-igw.id}"
}
# Create NAT route access
resource "aws_route" "windfire-nat-route" {
  route_table_id = "${aws_route_table.windfire-private-route.id}"
  destination_cidr_block = "${var.allIPsCIDRblock}"
  nat_gateway_id = "${aws_nat_gateway.windfire-ngw.id}"
}
# Create Subnets
resource "aws_subnet" "windfire-frontend-subnet1" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  cidr_block = "${var.cidr["frontend"]}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone = "${var.availabilityZone}"
  tags = {
    Name = "${var.subnet["frontend"]}"
  }
}
resource "aws_subnet" "windfire-backend-subnet1" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  cidr_block = "${var.cidr["backend"]}"
  availability_zone = "${var.availabilityZone}"
  tags = {
    Name = "${var.subnet["backend"]}"
  }
}
resource "aws_subnet" "windfire-bastion-subnet" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  cidr_block = "${var.cidr["bastion"]}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone = "${var.availabilityZone}"
  tags = {
    Name = "${var.subnet["bastion"]}"
  }
}
# Create Network Access Control Lists
resource "aws_network_acl" "windfire-frontend-acl" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  subnet_ids = [ "${aws_subnet.windfire-frontend-subnet1.id}" ]
  # allow ingress ephemeral ports from all IPs
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 0
    to_port    = 65535
  }
  # allow egress ephemeral ports to all IPs
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 0
    to_port    = 65535
  }
  tags = {
    Name = "${var.acl["public"]}"
  }
}
resource "aws_network_acl" "windfire-backend-acl" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  subnet_ids = [ "${aws_subnet.windfire-backend-subnet1.id}" ]
  # allow ingress ephemeral ports from all IPs
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 0
    to_port    = 65535
  }
  # allow egress ephemeral ports to all IPs
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 0
    to_port    = 65535
  }
  tags = {
    Name = "${var.acl["private"]}"
  }
}
resource "aws_network_acl" "windfire-bastion-acl" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  subnet_ids = [ "${aws_subnet.windfire-bastion-subnet.id}" ]
  # allow ingress SSH port 22 from all IPs
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 22
    to_port    = 22
  }
  # allow ingress ephemeral ports from Frontend subnet IPs
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.cidr["frontend"]}"
    from_port  = 1024
    to_port    = 65535
  }
  # allow ingress ephemeral ports from Backend subnet IPs
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "${var.cidr["backend"]}"
    from_port  = 1024
    to_port    = 65535
  }
  # allow egress ephemeral ports to all IPs
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.allIPsCIDRblock}"
    from_port  = 0
    to_port    = 65535
  }
  tags = {
    Name = "${var.acl["bastion"]}"
  }
}
# Create Security Groups
resource "aws_security_group" "windfire-frontend-securitygroup" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  # allow ingress HTTP port 80 from all IPs
  ingress {
    cidr_blocks = [ "${var.allIPsCIDRblock}" ]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  # allow ingress HTTPS port 443 from all IPs
  ingress {
    cidr_blocks = [ "${var.allIPsCIDRblock}" ]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }
  # allow ingress SSH port 22 from Bastion host subnet IPs
  ingress {
    cidr_blocks = [ "${var.cidr["bastion"]}" ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # allow egress ephemeral ports to all IPs
  egress {
    cidr_blocks = [ "${var.allIPsCIDRblock}" ]
    from_port  = 0
    to_port    = 65535
    protocol   = "tcp"
  }
  tags = {
    Name = "${var.security-group["frontend"]}"
  }
}
resource "aws_security_group" "windfire-backend-securitygroup" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  # allow ingress HTTP port 8080 from Frontend Security Group
  ingress {
    security_groups = [ "${aws_security_group.windfire-frontend-securitygroup.id}" ]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }
  # allow ingress SSH port 22 from Bastion host subnet IPs
  ingress {
    cidr_blocks = [ "${var.cidr["bastion"]}" ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # allow egress ephemeral ports to all IPs
  egress {
    cidr_blocks = [ "${var.allIPsCIDRblock}" ]
    from_port  = 0
    to_port    = 65535
    protocol   = "tcp"
  }
  tags = {
    Name = "${var.security-group["backend"]}"
  }
}
resource "aws_security_group" "windfire-bastion-securitygroup" {
  vpc_id = "${aws_vpc.windfire-vpc.id}"
  # allow ingress SSH port 22 from all IPs
  ingress {
    cidr_blocks = [ "${var.allIPsCIDRblock}" ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # allow egress SSH port 22 to Frontend Security Group
  egress {
    security_groups = [ "${aws_security_group.windfire-frontend-securitygroup.id}" ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # allow egress SSH port 22 to Backend Security Group
  egress {
    security_groups = [ "${aws_security_group.windfire-backend-securitygroup.id}" ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  tags = {
    Name = "${var.security-group["bastion"]}"
  }
}
# Associate Route Tables with Subnets
resource "aws_route_table_association" "windfire-frontend-association" {
  subnet_id = "${aws_subnet.windfire-frontend-subnet1.id}"
  route_table_id = "${aws_route_table.windfire-public-route.id}"
}
resource "aws_route_table_association" "windfire-bastion-association" {
  subnet_id = "${aws_subnet.windfire-bastion-subnet.id}"
  route_table_id = "${aws_route_table.windfire-public-route.id}"
}
resource "aws_route_table_association" "windfire-backend-association" {
  subnet_id = "${aws_subnet.windfire-backend-subnet1.id}"
  route_table_id = "${aws_route_table.windfire-private-route.id}"
}
#####################################################
################### End - AWS VPC ###################
#####################################################