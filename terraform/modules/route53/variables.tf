variable "environment" {
	type        = string
	description = "Environment name."
}

variable "notes_lb_dns_name" {
	type = string
	description = "Backend API Load Balancer to attach to the Route53."
}

variable "notes_lb_zone_id" {
	type = string
	description = "Zone ID of the Load Balancer."
}
