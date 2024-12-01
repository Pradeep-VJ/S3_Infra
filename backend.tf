# Remote backend configuration for Terraform state
terraform {
  backend "s3" {
    bucket         = "terraform-statefile-astra"  # Bucket for the state file
    key            = "terraform/statefile.tfstate"  # Path within the bucket
    region         = "us-east-1"                 # AWS region
  }
}
