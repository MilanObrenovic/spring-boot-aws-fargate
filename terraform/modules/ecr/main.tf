# Elastic Container Registry (ECR) Repository
resource "aws_ecr_repository" "terraform_aws_fargate_repository" {
	name = var.ecr_repository_name

	# MUTABLE = allows image tags to be overwritten.
	# IMMUTABLE = prevents image tags from being overwritten by subsequent image pushes using the same tag.
	image_tag_mutability = "MUTABLE"

	# If enabled, it will delete the entire repository even if there are still some images inside.
	force_delete = true

	image_scanning_configuration {
		# If enabled, each image will be automatically scanned after being pushed to the repository.
		# If disabled, each image scan must be manually started to get scan results.
		scan_on_push = true
	}

	encryption_configuration {
		# Encrypts images stored in this repository, instead of using the default encryption settings.
		encryption_type = "KMS"
	}
}
