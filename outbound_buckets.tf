# Outbound S3 bucket configuration
resource "aws_s3_bucket" "outbound_s3" {
  bucket = "outbound-astra-files"  # Name of the bucket

  tags = {
    Owner       = "Pradeep_Reddy_B"
    Environment = "QA"
    MedicalData = "false"
    PIIData     = "true"
    CreditData  = "false"
  }
}
# Lifecycle configuration for restricted bucket
resource "aws_s3_bucket_lifecycle_configuration" "outbound_s3_lifecycle" {
  bucket = aws_s3_bucket.outbound_s3.id

  rule {
    id     = "Expire-in-15days"
    status = "Enabled"

    expiration {
      days = 15  # Expire objects after 15 days
    }
  }
}
