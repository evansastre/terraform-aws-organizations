# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket  = "prod-sg-aws-org-tf-state"
    encrypt = true
    key     = "aws-org/datadog/terraform.tfstate"
    region  = "ap-southeast-1"
  }
}