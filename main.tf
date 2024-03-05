terraform {
  required_version = "~> 1.3"

  backend "s3" {
    bucket         = "test-bucket-for-tf-state-backend"
    dynamodb_table = "test-tf-state-backend"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
  }


  required_providers {
    aws = {
      version = "~> 5.39.0"
      source  = "hashicorp/aws"
    }
  }
}


module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = local.tf_state_bucket_name
  table_name  = local.tf_state_table_name
}

module "ecr-repo" {
  source        = "./modules/ecr"
  ecr_repo_name = local.ecr_repo_name
}

module "ecs" {
  source = "./modules/ecs"

  ecr_repo_url = module.ecr-repo.repository_url

  ecs_cluster_name               = local.ecs_cluster_name
  availability_zones             = local.availability_zones
  ecs_task_famliy                = local.ecs_task_famliy
  container_port                 = local.container_port
  container_name                 = local.container_name
  ecs_task_execution_role_name   = local.ecs_task_execution_role_name
  application_load_balancer_name = local.application_load_balancer_name
  target_group_name              = local.target_group_name
  ecs_service_name               = local.ecs_service_name
}

module "rds" {
  source = "./modules/rds"

  cluster_name      = local.cluster_name
  database_name     = local.cluster_name
  database_username = local.cluster_name
}
