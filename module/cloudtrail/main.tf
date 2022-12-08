resource "aws_s3_bucket" "this" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = var.s3_bucket_name

}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.this[0].id

  rule {
    id = "log"

    status = var.enable_s3_bucket_expiration ? "Enabled" : "Disabled"

    expiration {
      days = var.s3_bucket_days_to_expiration
    }

    transition {
      days          = var.s3_bucket_days_to_transition
      storage_class = var.s3_bucket_transition_storage_class
    }
  }
}


resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this[0].id

  # Block new public ACLs and uploading public objects
  block_public_acls = true

  # Retroactively remove public access granted through public ACLs
  ignore_public_acls = true

  # Block new public bucket policies
  block_public_policy = true

  # Retroactivley block public and cross-account access if bucket has public policies
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "this" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = aws_s3_bucket.this[0].id
  policy = coalesce(var.s3_bucket_policy, data.aws_iam_policy_document.this[0].json)

  depends_on = [
    data.aws_iam_policy_document.this
  ]
}


data "aws_iam_policy_document" "this" {
  count = var.create_s3_bucket ? 1 : 0

  statement {
    sid       = "AWSCloudTrailAclCheck"
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.this[0].arn]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid     = "AWSCloudTrailWrite"
    actions = ["s3:PutObject"]

    resources = ["${var.s3_key_prefix != "" ? format("%s/%s/*", aws_s3_bucket.this[0].arn, var.s3_key_prefix) : format("%s/*", aws_s3_bucket.this[0].arn)}"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}


resource "aws_cloudtrail" "this" {
  name           = var.trail_name
  s3_bucket_name = var.s3_bucket_name
  s3_key_prefix  = var.s3_key_prefix

  enable_logging                = var.enable_logging
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = var.enable_log_file_validation
  is_organization_trail         = var.is_organization_trail

  event_selector {
    exclude_management_event_sources = ["rdsdata.amazonaws.com"]
  }


  depends_on = [aws_s3_bucket.this[0]]
}