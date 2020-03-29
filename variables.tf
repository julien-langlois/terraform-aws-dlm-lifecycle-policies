variable "unique_name" {
  description = "Enter Unique Name to identify the Terraform Stack (lowercase)"
  type        = string
  default     = "v1"
}

variable "stack_prefix" {
  description = "Stack Prefix for resource generation"
  type        = string
  default     = "dlm_lifecycle"
}

variable "dlm_policies" {
  description = "DLM Policies to be created"
  type        = list(map(string))
}
