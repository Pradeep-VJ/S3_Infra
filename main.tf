provider "aws" {
  region = "us-east-1" # Specify your AWS region
}

resource "aws_s3_bucket" "inbound_s3" {
  bucket = "inbound-astra-files"
  tags = {
    Owner        = "Pradeep_Reddy_B"
    Environment  = "QA"
    MedicalData  = "false"
    PIIData      = "true"
    CreditData   = "false"
  }
  lifecycle_rule {
    enabled = false
    id      = "TransitionToDeepArchive"
    prefix  = ""
    transition {
      days          = 21
      storage_class = "GLACIER_DEEP_ARCHIVE"
    }
  }
}

