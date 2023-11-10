# VPC
resource "aws_vpc" "vpc" {
	cidr_block           = var.vpc_cidr
	enable_dns_hostnames = true
	enable_dns_support   = true

	tags = {
		Name        = "${var.environment}-vpc"
		Environment = var.environment
	}
}

# Public subnets
resource "aws_subnet" "public_subnets" {
	vpc_id                  = aws_vpc.vpc.id
	count                   = length(var.public_subnets_cidr)
	cidr_block              = element(var.public_subnets_cidr, count.index)
	availability_zone       = element(local.availability_zones, count.index)
	map_public_ip_on_launch = true

	tags = {
		Name        = "${var.environment}-${element(local.availability_zones, count.index)}-public-subnet"
		Environment = var.environment
	}
}

# Private subnets
resource "aws_subnet" "private_subnets" {
	vpc_id                  = aws_vpc.vpc.id
	count                   = length(var.private_subnets_cidr)
	cidr_block              = element(var.private_subnets_cidr, count.index)
	availability_zone       = element(local.availability_zones, count.index)
	map_public_ip_on_launch = false

	tags = {
		Name        = "${var.environment}-${element(local.availability_zones, count.index)}-private-subnet"
		Environment = var.environment
	}
}

# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "private_route_table" {
	vpc_id = aws_vpc.vpc.id
	count  = length(var.private_subnets_cidr)

	tags = {
		Name        = "${var.environment}-${element(local.availability_zones, count.index)}-private-route-table"
		Environment = var.environment
	}
}

# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "public_route_table" {
	vpc_id = aws_vpc.vpc.id

	tags = {
		Name        = "${var.environment}-public-route-table"
		Environment = var.environment
	}
}

# Internet Gateway (IGW)
resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.vpc.id

	tags = {
		Name        = "${var.environment}-igw"
		Environment = var.environment
	}
}

# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
	domain     = "vpc"
	depends_on = [
		aws_internet_gateway.igw,
	]
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
	allocation_id = aws_eip.nat_eip.id
	subnet_id     = element(aws_subnet.public_subnets.*.id, 0)

	tags = {
		Name        = "${var.environment}-nat-gateway"
		Environment = var.environment
	}
}

# Route for Internet Gateway (IGW)
resource "aws_route" "public_internet_gateway" {
	route_table_id         = aws_route_table.public_route_table.id
	gateway_id             = aws_internet_gateway.igw.id
	destination_cidr_block = "0.0.0.0/0"
}

# Route for NAT Gateway
resource "aws_route" "private_internet_gateway" {
	count                  = length(var.private_subnets_cidr)
	route_table_id         = element(aws_route_table.private_route_table.*.id, count.index)
	gateway_id             = aws_nat_gateway.nat.id
	destination_cidr_block = "0.0.0.0/0"
}

# Route table associations for Public Subnets
resource "aws_route_table_association" "public" {
	count          = length(var.public_subnets_cidr)
	subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
	route_table_id = aws_route_table.public_route_table.id
}

# Route table associations for Private Subnets
resource "aws_route_table_association" "private" {
	count          = length(var.private_subnets_cidr)
	subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
	route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}
