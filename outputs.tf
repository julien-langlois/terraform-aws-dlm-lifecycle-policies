output "policies_arns" {
  description = "Amazon Resource Name (ARN) of the DLM Lifecycle Policy"
  value       = aws_dlm_lifecycle_policy.policies[*].arn
}

output "id" {
  description = "Identifier of the DLM Lifecycle Policy"
  value       = aws_dlm_lifecycle_policy.policies[*].id
}
