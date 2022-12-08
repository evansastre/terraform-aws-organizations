
resource "aws_organizations_policy" "scp" {
  for_each = var.scp

  name = each.value.name
  type = "SERVICE_CONTROL_POLICY"

  content = each.value.content
}

resource "aws_organizations_policy" "tag-policy" {
  for_each = var.tag-policy

  name = each.value.name
  type = "TAG_POLICY"

  content = each.value.content
}


resource "aws_organizations_policy_attachment" "this" {
  for_each = var.policy_attachment

  policy_id = try(aws_organizations_policy.scp[each.value.policy_name].id, aws_organizations_policy.tag-policy[each.value.policy_name].id)
  target_id = each.value.target_id

  depends_on = [
    aws_organizations_policy.scp,
    aws_organizations_policy.tag-policy
  ]
}