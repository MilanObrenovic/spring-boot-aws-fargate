variable "environment" {
	type        = string
	description = "Environment name."
}

variable "route53_zone_id" {
	type = string
	description = "Route53 zone ID."
}

variable "notes_lb_arn" {
	type = string
	description = "Load Balancer ARN."
}

variable "notes_lb_target_group_arn" {
	type = string
	description = "Load Balancer target group ARN."
}
