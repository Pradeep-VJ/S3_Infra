# Inbound S3 bucket configuration
resource "aws_s3_bucket" "inbound_s3" {
  bucket = "inbound-astra-files"  # Name of the bucket
  tags = {
    Owner       = "Pradeep_Reddy_B"
    Environment = "QA"
    MedicalData = "false"
    PIIData     = "true"
    CreditData  = "false"
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "inbound_s3_versioning" {
  bucket = aws_s3_bucket.inbound_s3.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle configuration for inbound bucket
resource "aws_s3_bucket_lifecycle_configuration" "inbound_s3_lifecycle" {
  bucket = aws_s3_bucket.inbound_s3.id
  rule {
    id     = "Expire-in-30days"
    status = "Enabled"
    expiration {
      days = 30  # Expire objects after 30 days
    }
  }
}

# Add S3 Event Notification to Trigger SNS
resource "aws_s3_bucket_notification" "inbound_s3_notification" {
  bucket = aws_s3_bucket.inbound_s3.id
  
  topic {
    id = "Experian_Daily_File_Available"
    topic_arn = "arn:aws:sns:us-east-1:992382544193:experian_inbound_file_notifications"
    events    = ["s3:ObjectCreated:*"]
    filter_suffix = "metadata.json"
    filter_prefix = "daily_batch/"
  }
}

