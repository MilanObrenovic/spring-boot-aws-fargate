output "notes_lb_dns_name" {
	value = aws_lb.notes_lb.dns_name
}

output "notes_lb_zone_id" {
	value = aws_lb.notes_lb.zone_id
}

output "notes_lb_arn" {
	value = aws_lb.notes_lb.arn
}

output "notes_lb_target_group_arn" {
	value = aws_lb_target_group.notes_lb_target_group.arn
}
