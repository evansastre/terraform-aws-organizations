terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//cf-stackset-identity-provider"
}



include {
  path = find_in_parent_folders()
}


inputs = {

  name = "IdP-provider-stackset"
  ## sandbox, stage and prod OU
  organizational_unit_id = ["ou-xxx1-xxxxxx1", "ou-xxx1-xxxxxx2", "ou-xxx1-xxxxxx3"]
}
