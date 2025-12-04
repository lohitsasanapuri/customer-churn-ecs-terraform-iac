terraform {
  backend "s3" {
    bucket  = "customer-churn-terraform-state"
    key     = "ecs/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    #profile = "ecs-dev" 
  }
}
