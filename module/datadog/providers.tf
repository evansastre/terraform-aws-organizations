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