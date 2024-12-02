provider "aws" {
  region = "us-east-1" # Replace with your preferred AWS region
}

# S3 Bucket for Terraform State File
resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-statefile-astra"  # Replace with your desired bucket name

  # Enable versioning for state file rollback and history tracking
  versioning {
    enabled = true
  }

  # Enable server-side encryption for security
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Add tags for better resource identification and management
  tags = {
    Name        = "terraform-statefile-astra"
    Environment = "Bootstrap"
  }
}

# DynamoDB Table for State Locking (Optimized for Free Tier)
resource "aws_dynamodb_table" "state_lock_table" {
  name         = "terraform-lock-table" # Replace with your desired table name
  billing_mode = "PAY_PER_REQUEST"      # Pay only for actual usage (Free Tier eligible)

  # Define the primary key
  attribute {
    name = "LockID"
    type = "S" # String
  }

  # Add tags for better resource management
  tags = {
    Name        = "terraform-lock-table"
    Environment = "Bootstrap"
  }
}

# Outputs for verification and debugging
output "state_bucket_name" {
  description = "The name of the S3 bucket used for Terraform state"
  value       = aws_s3_bucket.state_bucket.id
}

output "lock_table_name" {
  description = "The name of the DynamoDB table used for state locking"
  value       = aws_dynamodb_table.state_lock_table.name
}
