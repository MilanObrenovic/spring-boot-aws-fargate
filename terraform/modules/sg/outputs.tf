output "notes_rds_security_group_id" {
	value = aws_security_group.notes_rds_security_group.id
}

output "notes_fargate_security_group_id" {
	value = aws_security_group.notes_fargate_security_group.id
}

output "notes_lb_security_group_id" {
	value = aws_security_group.notes_lb_security_group.id
}
