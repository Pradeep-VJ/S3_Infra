provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_s3_bucket" {
  bucket = "inbound-astra-files"
  tags = {
    Owner       = "Pradeep_Reddy_B"
    Environment = "QA"
    MedicalData = "false"
    PIIData     = "false"
    CreditData  = "false"
  }

  lifecycle_rule = local.lifecycle_rule
}

resource "aws_s3_bucket" {
  bucket = "restricted-astra-files"
  tags = {
    Owner       = "Pradeep_Reddy_B"
    Environment = "QA"
    MedicalData = "false"
    PIIData     = "true"
    CreditData  = "true"
  }

  lifecycle_rule = local.lifecycle_rule
}

# Common lifecycle rule
variable "common_lifecycle_rule" {
  default = {
    enabled = true
    id      = "Expire-in-30days"
    prefix  = ""
    expiration = {
      days = 30
    }
  }
}

# Function to apply the common lifecycle rule
locals {
  lifecycle_rule = [
    {
      enabled    = var.common_lifecycle_rule["enabled"]
      id         = var.common_lifecycle_rule["id"]
      prefix     = var.common_lifecycle_rule["prefix"]
      expiration = var.common_lifecycle_rule["expiration"]
    }
  ]
}
