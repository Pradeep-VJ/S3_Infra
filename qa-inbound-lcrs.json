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

  # Referencing the lifecycle rules JSON file directly
  lifecycle_rule {
    lifecycle_policy_file = "https://github.com/Pradeep-VJ/S3_Infra/blob/main/qa-inbound-lcrs.json"
  }
}
