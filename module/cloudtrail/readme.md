# Cloud Trail

This module is to enable cloudtrail in the master or any child account.


## Argument reference

Input

| Field      | Description | Required|
| ----------- | ----------- |---------|
| trail_name    |  name of the cloudtrail : default "trail-test"   | Yes|
|create_s3_bucket|specify whether to create a new S3 bucket for this cloudtrail.  default: true| Yes|
|s3_bucket_name| name of the s3 bucket|Yes|
|enable_s3_bucket_expiration|enable an expiration policy for the s3 bucket or not. default : false|No|
|s3_bucket_days_to_expiration|How many days to store logs before deleted. Only applies if `enable_s3_bucket_expiration` is true.  default: 90|No|
|enable_s3_bucket_transition| Specify whether to enable a storage class transition for the S3 bucket. default false| No|
|s3_bucket_days_to_transition|How many days to store logs before they will be transitioned to a cold storage. default: 30 |No|
|s3_bucket_transition_storage_class|Specify the S3 storage class to which logs will transition for archive. default:ONEZONE_IA |NO|
|s3_bucket_policy|s3 bucket policy. default : ""|No|
|enable_logging|Specify whether to enable logging for the trail. default: true|No|
|include_global_service_events|Specify whether the trail is publishing events from global services such as IAM. default: true|No|
|is_multi_region_trail| Specify whether the trail is created in the current region or in all regions. default: false|No|
|enable_log_file_validation|Specify whether log file integrity validation is enabled. default: false|No|
|is_organization_trail|Specify whether the trail is an AWS Organizations trail (master account only). default: false|No|
|s3_key_prefix|Specify the S3 key prefix. default: ""|No|
|tags|tags: default {}|No|

Output values:

| value      | Description | 
| ----------- | ----------- |
| id | The id of the cloudtrail.|
|arn| The Amazon Resource Name of the trail.|

## Folder layout
```
deploy/<env>
├── cloudtrail
│   └── terragrunt.hcl
|── <other components>
|   └── ...
├── terragrunt.hcl
├── backend.tf
├── povider.tf
└── versions_override.tf

```
The root terragrunt.hcl will create/override versions_override.tf, backend.tf and provider.tf.

```
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "<your s3 bucket>"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-1"
#    dynamodb_table = "dynamodb-aws-org-test-tf-lock-table"
    encrypt        = true
  }
}

generate "versions" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = ">=4.5.0"
        }
      }
    }
EOF
}

```

this is an example for cloudtrail/terragrunt.hcl
```
terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//cloudtrail"
}



include {
  path = find_in_parent_folders()
}


inputs = {

  create_s3_bucket = true
  s3_bucket_name   = "<cloudtrail-enterprise-management-test-account>"

  enable_s3_bucket_expiration  = true
  s3_bucket_days_to_expiration = 90

  enable_s3_bucket_transition        = true
  s3_bucket_days_to_transition       = 35
  s3_bucket_transition_storage_class = "ONEZONE_IA"

  enable_logging             = true
  enable_log_file_validation = false

  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = false
}

```



