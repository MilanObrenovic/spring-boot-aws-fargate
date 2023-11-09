variable "environment" {
	type        = string
	description = "Environment name."
}

variable "private_subnets_cidr" {
	type        = list(string)
	description = "CIDR block for Private Subnets."
}
