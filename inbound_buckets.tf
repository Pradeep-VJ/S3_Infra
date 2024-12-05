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
