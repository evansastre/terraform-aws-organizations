
terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//policy"
}

include {
  path = find_in_parent_folders()
}

## define the OU_id variable here
locals {
    sandbox_ou_id = "ou-xxx1-xxxxxx1"
    stage_ou_id = "ou-xxx1-xxxxxx2"
    prod_ou_id    = "ou-xxx1-xxxxxx3"
}

inputs ={

  ### create scp policy
  # parameters:
  # name: policy name
  # path: location of the scp json file in the repo
  scp = {
    "1-Deny-Base-Rule" = {
      name = "1-Deny-Base-Rule"
      content = file("${get_path_to_repo_root()}/source/scp-policy/1-Deny-Base-Rule.json")
    }
    "2-Deny-Write-Access-To-Essential-Workload-Services" = {
      name = "2-Deny-Write-Access-To-Essential-Workload-Services"
      content = file("${get_path_to_repo_root()}/source/scp-policy/2-Deny-Write-Access-To-Essential-Workload-Services.json")
    }
    "3-Deny-Write-Access-To-All-Security-Services" = {
      name = "3-Deny-Write-Access-To-All-Security-Services"
      content = file("${get_path_to_repo_root()}/source/scp-policy/3-Deny-Write-Access-To-All-Security-Services.json")
    }
    "4-Deny-Write-Access-To-Essential-DevOps-Services" = {
      name = "4-Deny-Write-Access-To-Essential-DevOps-Services"
      content = file("${get_path_to_repo_root()}/source/scp-policy/4-Deny-Write-Access-To-Essential-DevOps-Services.json")
    }

  }

  ### create tag policy
  # parameters:
  # name: policy name
  # path: location of the scp json file in the repo
  # tag-policy = {
  #   costcenter = {
  #     name = "costcenter" 
  #     content = file("${get_path_to_repo_root()}/source/tag-policy/costcenter.json")
  #   }
  # }

  ### attache the policy to a target(could be root_id, OU_id, or account_id)
  ## parameter:
  #  target_id: ou_id, root_id or acount_id
  #  policy_name: the name of scp you'd like to attach -  it must exist in above scps block

  policy_attachment = {
    
    "Sandbox-1-Deny-Base-Rule" = {
        policy_name = "1-Deny-Base-Rule"
        target_id = "${local.sandbox_ou_id}"
    }
    "prod-1-Deny-Base-Rule" = {
        policy_name = "1-Deny-Base-Rule"
        target_id = "${local.prod_ou_id}"
    }
    "prod-2-Deny-Write-Access-To-Essential-Workload-Services" = {
        policy_name = "2-Deny-Write-Access-To-Essential-Workload-Services"
        target_id = "${local.prod_ou_id}"
    }
    "prod-3-Deny-Write-Access-To-All-Security-Services" = {
        policy_name = "3-Deny-Write-Access-To-All-Security-Services"
        target_id = "${local.prod_ou_id}"
    }
    "prod-4-Deny-Write-Access-To-Essential-DevOps-Services" = {
        policy_name = "4-Deny-Write-Access-To-Essential-DevOps-Services"
        target_id = "${local.prod_ou_id}"
    }
    "stage-1-Deny-Base-Rule" = {
        policy_name = "1-Deny-Base-Rule"
        target_id = "${local.stage_ou_id}"
    }
    "stage-2-Deny-Write-Access-To-Essential-Workload-Services" = {
        policy_name = "2-Deny-Write-Access-To-Essential-Workload-Services"
        target_id = "${local.stage_ou_id}"
    }
    "stage-3-Deny-Write-Access-To-All-Security-Services" = {
        policy_name = "3-Deny-Write-Access-To-All-Security-Services"
        target_id = "${local.stage_ou_id}"
    }
    "stage-4-Deny-Write-Access-To-Essential-DevOps-Services" = {
        policy_name = "4-Deny-Write-Access-To-Essential-DevOps-Services"
        target_id = "${local.stage_ou_id}"
    }
  }
}