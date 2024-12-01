###################
## S3 Buckets
###################
data "external" "check_inbound_bucket" {
  program = ["python3", "check_bucket.py", "inbound-astra-files"]
}

resource "aws_s3_bucket" "inbound_s3" {
  bucket = "inbound-astra-files"
  tags = {
    Owner       = "Pradeep_Reddy_B"
    Environment = "QA"
    MedicalData = "false"
    PIIData     = "true"
    CreditData  = "false"
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [acl, tags]
  }
  # Enable versioning
  versioning {
    enabled = true
  }
  lifecycle_rule {
    enabled = true
    id      = "Expire-in-30days"
    prefix  = ""
    expiration {
      days = 30
    }
  }
}

############################
## S3 Event Notifications
############################
resource "aws_s3_bucket_notification" "inbound_s3_notification" {
  bucket = aws_s3_bucket.inbound_s3.id
  topic {
    topic_arn = "arn:aws:sns:us-east-1:992382544193:experian_file_notifications" # Replace with the actual ARN from your SNS repository
    events    = ["s3:ObjectCreated:*"]
    #filter {
      #prefix = "nightly_batch/"
      #suffix = "metadata.json"
    #}
  }
}
