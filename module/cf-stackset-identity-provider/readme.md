# CloudFormation Stack set to create IAM role and Identity Provider

This module is to create enterpriseAdmin role and set up enterprise IAM Identity Provider in each child account.

We will use terraform to create a cloudformation stackset to provision the required resources. The cf stackset won't apply anything to management account.

`template.yaml is the file of cloudformation template.`

## Argument reference

Input

| Field      | Description | Required|
| ----------- | ----------- |---------|
| name    |  name of the cloudformation stackset : default ""   | Yes|
|permission_model|Describes how the IAM roles required for your StackSet are created.  default: SERVICE_MANAGED| Yes|
|region| region of the stackset. default : ap-southeast-1 |Yes|
|tags|tags: default {}|No|

Output values:

| value      | Description | 
| ----------- | ----------- |
| id | The id of the cloudtrail.|
|arn| The Amazon Resource Name of the trail.|

## Folder layout
```
deploy/<env>
├── cf-stackset-iam
│   └── terragrunt.hcl
|── <other components>
|   └── ...
├── terragrunt.hcl
├── backend.tf
├── povider.tf
└── versions_override.tf

```
The root terragrunt.hcl will create/override versions_override.tf, backend.tf and provider.tf

```
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "<your s3 bucket: like s3-aws-org-test-tf-state>"
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

this is an example for cf-stackset-iam/terragrunt.hcl
```
terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//cf-stackset-iam"
}



include {
  path = find_in_parent_folders()
}


inputs = {

  name = "test-stackset"
}


```



