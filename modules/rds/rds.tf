resource "aws_kms_key" "kms_for_test_rds" {
}

resource "aws_rds_cluster" "test" {
  cluster_identifier = var.cluster_name
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "15.4"
  database_name      = var.database_name
  master_username    = var.database_username
  storage_encrypted  = true

  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.kms_for_test_rds.key_id

  serverlessv2_scaling_configuration {
    max_capacity = 16
    min_capacity = 2
  }
}

resource "aws_rds_cluster_instance" "example" {
  cluster_identifier = aws_rds_cluster.test.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.test.engine
  engine_version     = aws_rds_cluster.test.engine_version
}
