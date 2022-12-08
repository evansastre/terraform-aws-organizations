terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//iam-roles"
}



include {
  path = find_in_parent_folders()
}

locals {
    sandbox_ou_id = "ou-xxx1-xxxxxx1"
    stage_ou_id = "ou-xxx1-xxxxxx2"
    prod_ou_id    = "ou-xxx1-xxxxxx3"
}

inputs = {

  iam_roles = {

    ## roles will be created in the sandbox OU accounts
    sandbox = {
      stackset_name = "sandbox-stackset"
      template_body = file("${get_path_to_repo_root()}/source/roles/sandbox/roles.yml")
      target_ids = ["${local.sandbox_ou_id}"]
    }
    stage = {
      stackset_name = "stage-roles-stackset"
      template_body = file("${get_path_to_repo_root()}/source/roles/stage/roles.yml")
      target_ids = ["${local.stage_ou_id}"]
    }
    prod = {
      stackset_name = "prod-roles-stackset"
      template_body = file("${get_path_to_repo_root()}/source/roles/prod/roles.yml")
      target_ids = ["${local.prod_ou_id}","${local.prod_old_ou_id}"]
    }
  }

}
