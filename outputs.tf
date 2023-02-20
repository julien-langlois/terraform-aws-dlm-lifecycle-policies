output "arns" {
  description = "Amazon Resource Name (ARN) of the DLM Lifecycle Policy"
  value       = aws_dlm_lifecycle_policy.policies[*].arn
}

output "ids" {
  description = "Identifier of the DLM Lifecycle Policy"
  value       = aws_dlm_lifecycle_policy.policies[*].id
}
