provider "aws" {
  region = "us-east-1" # Specify your AWS region
}
variable "lifecycle_policy_file_url" {
  default = "https://github.com/Pradeep-VJ/S3_Infra/blob/main/qa-inbound-lcrs.json"
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
    enabled = true
    source = var.lifecycle_policy_file_url
  }
}
