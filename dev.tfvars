aws_region     = "us-east-1"
app_name       = "ecs-webapp-dev"
docker_image   = "lohitsasanapuri/telco-fastapi:latest"
container_port = 8000   # IF your FastAPI runs on 8000
desired_count  = 1
