terraform {
  source = "${get_parent_terragrunt_dir()}/../../module//cloudtrail"
}



include {
  path = find_in_parent_folders()
}


inputs = {

  trail_name = "management-cloudtrail"
  create_s3_bucket = true
  s3_bucket_name   = "prod-cloudtrail-enterprise-management-account"

  enable_s3_bucket_expiration  = true
  s3_bucket_days_to_expiration = 90

  enable_s3_bucket_transition        = true
  s3_bucket_days_to_transition       = 35
  s3_bucket_transition_storage_class = "ONEZONE_IA"
  #s3_bucket_policy                   = file("${get_terragrunt_dir()}/s3-bucket-policy.json")

  enable_logging             = true
  enable_log_file_validation = false

  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = true

}
