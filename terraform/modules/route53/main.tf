# Create a Route53 Hosted Zone
resource "aws_route53_zone" "notes_route53_zone" {
	name = "milanobrenovic.com"

	lifecycle {
		create_before_destroy = true
	}

	tags = {
		Name        = "${var.environment}-route53-zone"
		Environment = var.environment
	}
}

# Creates an A record for the backend Load Balancer API
resource "aws_route53_record" "notes_route53_record_http" {
	zone_id = aws_route53_zone.notes_route53_zone.zone_id
	name    = "notes-api.milanobrenovic.com"
	type    = "A"

	alias {
		name                   = var.notes_lb_dns_name
		zone_id                = var.notes_lb_zone_id
		evaluate_target_health = false
	}
}
