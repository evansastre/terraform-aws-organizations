
resource "aws_cloudformation_stack_set" "this" {
  for_each =  var.iam_roles

  name                    = each.value.stackset_name
  permission_model        = var.permission_model 
  auto_deployment {
    enabled = true
  }

  capabilities = ["CAPABILITY_NAMED_IAM"]
  template_body = "${each.value.template_body}"

  tags =  var.tags

  lifecycle {
    ignore_changes = [
      administration_role_arn
    ]
  }
}


#data "aws_organizations_organization" "this" {}

resource "aws_cloudformation_stack_set_instance" "this" {
  for_each = var.iam_roles

  deployment_targets {
    organizational_unit_ids = each.value.target_ids
  }
  stack_set_name = aws_cloudformation_stack_set.this[each.key].name
}
