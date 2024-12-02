provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-statefile-astra"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "terraform-statefile-astra"
    Environment = "Bootstrap"
  }
}

output "state_bucket_name" {
  value = aws_s3_bucket.state_bucket.id
}
