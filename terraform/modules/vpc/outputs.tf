output "vpc_id" {
	value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
	# Star takes ALL the subnets in this resource and creates a list
	value = aws_subnet.public_subnets.*.id
}

output "private_subnet_ids" {
	# Star takes ALL the subnets in this resource and creates a list
	value = aws_subnet.private_subnets.*.id
}
