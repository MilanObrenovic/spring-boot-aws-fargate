# ECS cluster
resource "aws_ecs_cluster" "notes_ecs_cluster" {
	name = "notes-api-dev-cluster"

	tags = {
		Name        = "${var.environment}-ecs-cluster"
		Environment = var.environment
	}
}
