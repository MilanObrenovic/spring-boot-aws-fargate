output "ecr_image_uri" {
	value = aws_ecr_repository.notes_api_repository.repository_url
}
