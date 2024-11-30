provider "aws" {
  region = "us-east-1" # Change to your desired region
}

variable "owner" {
  default = "Pradeep_Reddy_B"
}

variable "bucket_name" {
  default = "inbound-astra-files"
}

variable "lifecycle_policy_file_url" {
  default = "https://github.com/Pradeep-VJ/S3_Infra/blob/main/qa-inbound-lcrs.json"
}

resource "aws_s3_bucket" "inbound_s3" {
  bucket = var.bucket_name
  tags = {
    Owner       = var.owner
    Environment = "QA"
    MedicalData = "false"
    PIIData     = "true"
    CreditData  = "false"
  }

  lifecycle_rule {
    enabled = true
    id      = "lifecycle-rule"
    prefix  = ""
    expiration {
      days = 90
    }
  }
}
