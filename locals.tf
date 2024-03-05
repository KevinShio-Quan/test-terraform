locals {
  tf_state_bucket_name = "test-bucket-for-tf-state-backend"
  tf_state_table_name  = "test-tf-state-backend"

  ecr_repo_name = "test-ecr-repo"

  ecs_cluster_name = "test-cluster"
  ecs_service_name = "test-service"

  availability_zones           = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  ecs_task_famliy              = "test-task-def"
  container_port               = 3000
  container_name               = "test-task"
  ecs_task_execution_role_name = "test-task-execution-role"

  application_load_balancer_name = "cc-test-alb"
  target_group_name              = "cc-test-alb-tg"

  cluster_name      = "testcluster"
  database_name     = "testdb"
  database_username = "testdbusername"

}
