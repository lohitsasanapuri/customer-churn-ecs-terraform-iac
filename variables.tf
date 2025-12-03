variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "ecs-webapp"
}

variable "docker_image" {
  description = "Docker Hub image (e.g. nginx:latest or user/app:tag)"
  type        = string
  default     = "lohitsasanapuri/telco-fastapi:latest"
}

variable "container_port" {
  description = "Container port to expose"
  type        = number
  default     = 8000
}

variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}
