terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//cf-stackset-budget"
}



include {
  path = find_in_parent_folders()
}


inputs = {

  name = "cf-stackset-budget"
  ## sandbox, stage and prod OU
  organizational_unit_id = ["ou-x001-xxxxxx1"]
}
