output "notes_lb_dns_name" {
  # Output the Load Balancer DNS name.
  # This is the working Java Spring Boot backend API.
  value = module.ecs.notes_lb_dns_name
}
