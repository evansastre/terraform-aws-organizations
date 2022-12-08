variable "trail_name" {
  type        = string
  description = "Name of the trail."
  default     = "trail-test"
}


variable "create_s3_bucket" {
  type = bool
  description = "specify whether to create a new S3 bucket."
  default     = true
}

variable "s3_bucket_name" {
  type = string
  description = "Name of the S3 bucket"
  default = ""
}

variable "s3_bucket_policy" {
  type = any 
  description = "s3 bucekt policy"
  default = null
  
}
variable "enable_s3_bucket_expiration" {
  type = bool
  description = "enable an expiration policy or not."
  default     = "false"
}

variable "s3_bucket_days_to_expiration" {
  type = number
  description = "How many days to store logs before deleted. Only applies if `enable_s3_bucket_expiration` is true."
  default     = "90"
}

variable "enable_s3_bucket_transition" {
  type = bool
  description = "Specify whether to enable a storage class transition for the S3 bucket."
  default     = "true"
}

variable "s3_bucket_days_to_transition" {
  type = number
  description = "How many days to store logs before they will be transitioned to a cold storage."
  default     = "30"
}

variable "s3_bucket_transition_storage_class" {
  type = string
  description = "Specify the S3 storage class to which logs will transition for archive"
  default     = "ONEZONE_IA"
}

variable "enable_logging" {
  type = bool
  description = "Specify whether to enable logging for the trail."
  default     = "true"
}

variable "include_global_service_events" {
  type = bool
  description = "Specify whether the trail is publishing events from global services such as IAM."
  default     = "true"
}

variable "is_multi_region_trail" {
  type = bool
  description = "Specify whether the trail is created in the current region or in all regions."
  default     = "false"
}

variable "enable_log_file_validation" {
  type = bool
  description = "Specify whether log file integrity validation is enabled."
  default     = "false"
}

variable "is_organization_trail" {
  type = bool
  description = "Specify whether the trail is an AWS Organizations trail (master account only)."
  default     = "false"
}

variable "s3_key_prefix" {
  type  = string
  description = "Specify the S3 key prefix"
  default     = ""
}

variable tags {
    type = map 
    description = "tags"
    default = {}
}
