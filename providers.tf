provider "aws" {
  access_key = env("AWS_ACCESS_KEY_ID")
  secret_key = env("AWS_SECRET_ACCESS_KEY")
  region     = "us-east-1"
}
