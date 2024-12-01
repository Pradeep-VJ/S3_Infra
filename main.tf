provider "aws" {
  region = "us-east-1" # Change to your desired region
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

  lifecycle_rule {
    id      = "DeleteAllObjects"
    enabled = true
    prefix  = ""
    expiration { days = 7 }
    noncurrent_version_expiration { noncurrent_days = 30 }
    abort_incomplete_multipart_upload { days_after_initiation = 1 }
  }

  lifecycle_rule {
    id      = "TransitionToDeepArchive"
    enabled = false
    prefix  = ""
    transition {
      days          = 21
      storage_class = "GLACIER_DEEP_ARCHIVE"
    }
  }
}
