resource "aws_iam_role" "ecs_execution_role" {
	name               = "ecs-execution-role"
	assume_role_policy = jsonencode({
		Version   = "2012-10-17",
		Statement = [
			{
				Action    = "sts:AssumeRole",
				Effect    = "Allow",
				Principal = {
					Service = "ecs-tasks.amazonaws.com"
				}
			}
		]
	})

	tags = {
		Name        = "${var.environment}-iam-role"
		Environment = var.environment
	}
}

resource "aws_iam_policy" "ecs_execution_policy" {
	name        = "ecs-execution-policy"
	description = "Policy for ECS Fargate Execution Role"
	policy      = jsonencode({
		Version   = "2012-10-17",
		Statement = [
			{
				Action = [
					"ecr:GetAuthorizationToken",
					"ecr:GetDownloadUrlForLayer",
					"ecr:BatchCheckLayerAvailability",
					"ecr:GetRepositoryPolicy",
					"ecr:CreateRepository",
					"ecr:ListImages",
					"ecr:DescribeRepositories",
					"ecr:DescribeImages",
					"ecr:PutImage",
				],
				Effect   = "Allow",
				Resource = "*",
			},
			{
				Action = [
					"logs:CreateLogStream",
					"logs:CreateLogGroup",
					"logs:PutLogEvents",
				],
				Effect   = "Allow",
				Resource = "*",
			},
			{
				Action = [
					"ecs:CreateCluster",
					"ecs:DeregisterContainerInstance",
					"ecs:DiscoverPollEndpoint",
					"ecs:Poll",
					"ecs:RegisterContainerInstance",
					"ecs:StartTelemetrySession",
					"ecs:SubmitContainerStateChange",
					"ecs:SubmitTaskStateChange",
				],
				Effect   = "Allow",
				Resource = "*",
			},
		]
	})

	tags = {
		Name        = "${var.environment}-iam-policy"
		Environment = var.environment
	}
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_attachment" {
	policy_arn = aws_iam_policy.ecs_execution_policy.arn
	role       = aws_iam_role.ecs_execution_role.name
}
