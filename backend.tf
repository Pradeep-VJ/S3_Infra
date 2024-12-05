# Backend configuration for Terraform state
terraform {
  backend "s3" {
    bucket         = "astra-terraform-statefiles"  # Name of the S3 bucket for state file
    key            = "s3_statefile/terraform.tfstate"  # Path within the S3 bucket
    region         = "us-east-1"                 # AWS region where the bucket is located
    encrypt        = true                        # Enable encryption for the state file
    #dynamodb_table = "terraform-lock-table"      # DynamoDB table for state locking
  }
}
