output "id" {
  value       = aws_cloudtrail.this.id
  description = "The id of the cloudtrail."
}

output "arn" {
  value       = aws_cloudtrail.this.arn
  description = "The Amazon Resource Name of the trail."
}
