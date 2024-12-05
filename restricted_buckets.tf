# Restricted S3 bucket configuration
resource "aws_s3_bucket" "restricted_s3" {
  bucket = "restricted-astra-files"  # Name of the bucket

  tags = {
    Owner       = "Pradeep_Reddy_B"
    Environment = "QA"
    MedicalData = "false"
    PIIData     = "true"
    CreditData  = "false"
  }
}
# Lifecycle configuration for restricted bucket
resource "aws_s3_bucket_lifecycle_configuration" "restricted_s3_lifecycle" {
  bucket = aws_s3_bucket.restricted_s3.id

  rule {
    id     = "Expire-in-15days"
    status = "Enabled"

    expiration {
      days = 15  # Expire objects after 15 days
    }
  }
}
