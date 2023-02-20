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
  type = list(object({
    description     = string
    state           = optional(string, "ENABLED")
    resource_types  = optional(string, "VOLUME")
    snapshot_name   = optional(string, "")
    cron_expression = optional(string, null)
    start_time      = optional(string, "03:00")
    interval_hours  = optional(number, 24)
    interval_unit   = optional(string, "HOURS")
    retention_count = optional(number, 7)
    target_tags     = optional(map(string), { Snapshot = "true" })
    copy_tags       = optional(bool, false)
  }))
}
