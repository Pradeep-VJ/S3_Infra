
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
    enabled = true
    id      = "Expire-in-30days"
    prefix  = ""
    expiration {
      days = 30
    }
  }
}
