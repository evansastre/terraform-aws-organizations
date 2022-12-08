# CloudFormation Stack set to set up budget 


We will use terraform to set up a budget for aws account

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
├── cf-stackset-budget
│   └── terragrunt.hcl
|── <other components>
|   └── ...
├── terragrunt.hcl


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
    bucket         = "prod-sg-aws-org-tf-state"
    key            = "aws-org/${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-1"
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

this is an example for cf-stackset-budget/terragrunt.hcl
```
terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//cf-stackset-budget"
}



include {
  path = find_in_parent_folders()
}


inputs = {

  name = "cf-stackset-budget"
  ## sandbox, stage and prod OU
  organizational_unit_id = ["ou-w008-m1fgxkdl"]
}


```



