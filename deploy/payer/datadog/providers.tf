
terraform {
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = ">=4.5.0"
        }
        datadog = {
          source = "DataDog/datadog"
        }

      }
}


# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}


provider "aws" {
  alias = "sandbox-bus2"
  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
  
}

provider "aws" {
  alias = "sandbox-bus1"
  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
  
}



provider "aws" {
  alias = "stage-bus2"
  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
  
}


provider "aws" {
  alias = "stage-bus1"
  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
  
}



provider "aws" {
  alias = "prod-group"
  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
  
}


provider "aws" {
  alias = "prod-bus2"
  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
  
}


provider "aws" {
  alias = "prod-bus1"
  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
  
}


provider "aws" {
  alias = "enterprise-master-payer"
}

