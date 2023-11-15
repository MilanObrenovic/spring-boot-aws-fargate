# Creates an SSL certificate for the domain
resource "aws_acm_certificate" "notes_acm_certificate" {
	domain_name       = "*.milanobrenovic.com"
	validation_method = "DNS"
	key_algorithm     = "RSA_2048"

	lifecycle {
		create_before_destroy = true
		prevent_destroy       = false
	}

	tags = {
		Name        = "${var.environment}-acm-certificate"
		Environment = var.environment
	}
}

# Apply the generated SSL certificate to the existing Route53 Hosted Zone
resource "aws_route53_record" "notes_acm_validation_records" {
	for_each = {
		for dvo in aws_acm_certificate.notes_acm_certificate.domain_validation_options : dvo.domain_name => {
			name   = dvo.resource_record_name
			record = dvo.resource_record_value
			type   = dvo.resource_record_type
		}
	}

	allow_overwrite = true
	zone_id         = var.route53_zone_id
	name            = each.value.name
	type            = each.value.type
	records         = [each.value.record]
	ttl             = 60
}

# Validate the newly generated SSL certificate (this might take a while so be patient)
resource "aws_acm_certificate_validation" "notes_acm_certificate_validation" {
	certificate_arn         = aws_acm_certificate.notes_acm_certificate.arn
	validation_record_fqdns = [for record in aws_route53_record.notes_acm_validation_records : record.fqdn]
}

# Update the existing Load Balancer by adding a new Listener to listen on port 443
resource "aws_lb_listener" "notes_lb_listener_https" {
	load_balancer_arn = var.notes_lb_arn
	protocol          = "HTTPS"
	port              = 443
	certificate_arn   = aws_acm_certificate.notes_acm_certificate.arn

	default_action {
		type             = "forward"
		target_group_arn = var.notes_lb_target_group_arn
	}

	lifecycle {
		create_before_destroy = true
	}

	tags = {
		Name        = "${var.environment}-ecs-lb-listener-https"
		Environment = var.environment
	}
}
