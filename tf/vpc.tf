# Create a VPC to host the AWS Workspace Framework which includes:
# (1) Public subnet w/ NAT Gateway
# (2) Private subnets

# Allocate an Elastic IP for the NAT gateway
resource "aws_eip" "nat_gateway" {
  vpc      = true
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id = aws_subnet.drake-public-sn-1a.id
    tags = {
        Name = "NAT Gateway"
    }
}

resource "aws_vpc" "drake-vpc" {
    cidr_block = "170.0.0.0/16"
    # Provide an internal domain name
    enable_dns_support = "true"

    # Provide an internal host name
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags = {
        Name = "drake-vpc"
    }
}

resource "aws_subnet" "drake-public-sn-1a" {
    vpc_id = "${aws_vpc.drake-vpc.id}"
    cidr_block = "170.0.0.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-1a"
    tags = {
        Name = "Workspaces Public Subnet"
    }
}

resource "aws_subnet" "drake-private-sn-1b" {
    vpc_id = "${aws_vpc.drake-vpc.id}"
    cidr_block = "170.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "Workspaces Private Subnet 1"
    }
}

resource "aws_subnet" "drake-private-sn-1d" {
    vpc_id = "${aws_vpc.drake-vpc.id}"
    cidr_block = "170.0.2.0/24"
    availability_zone = "us-east-1d"
    tags = {
        Name = "Workspaces Private Subnet 2"
    }
}

