output "id" {
  value       = aws_cloudformation_stack_set.this.id
  description = "The id of the cloudformation stack set."
}


output "arn" {
  value       = aws_cloudformation_stack_set.this.arn
  description = "The arn of the cloudformation stack set."
}