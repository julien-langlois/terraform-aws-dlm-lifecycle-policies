# AWS DLM Lifecycle (Data Lifecycle Manager)

This terraform module is designed to help in using the AWS DLM Lifecycle. Each
volume that needs to be supported by the DLM Lifecycle must be tagged with
the tags defined by variable `target_tags` (default `Snapshot = "true"`)

## Usage

```hcl
module "dlm-lifecycle" {
  source = "julien-langlois/dlm-lifecycle-policies/aws"

  dlm_policies = [
    {
      description = "DLM7"
      snapshot_name = "Rolling backup 7 days"
      start_time = "01:00"
      interval_hours = 4
      retention_count = 7
    },
    {
      description = "DLM14"
      snapshot_name = "Rolling backup 14 days"
      start_time = "04:00"
      interval_hours = 12
      retention_count = 14
    },
    {
      description = "DLM30"
      snapshot_name = "Rolling backup 30 days"
      start_time = "21:00"
      interval_hours = 2
      retention_count = 30
    },
    {
      description = "DLM40"
      resource_types  = "INSTANCE"
      snapshot_name = "WeeklyBackupAMI"
      cron_expression = "cron(0 3 * * SUN *)" # Every Sunday 3am
      retention_count = 15
      target_tags = {
        Name = "instance-example"
        Snapshot = "DLM40"
      }
    },
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dlm_lifecycle_policy.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy) | resource |
| [aws_iam_role.dlm_lifecycle_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.dlm_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dlm_policies"></a> [dlm\_policies](#input\_dlm\_policies) | DLM Policies to be created | <pre>list(object({<br>    description     = string<br>    state           = optional(string, "ENABLED")<br>    resource_types  = optional(string, "VOLUME")<br>    snapshot_name   = optional(string, "")<br>    cron_expression = optional(string, null)<br>    start_time      = optional(string, "03:00")<br>    interval_hours  = optional(number, 24)<br>    interval_unit   = optional(string, "HOURS")<br>    retention_count = optional(number, 7)<br>    target_tags     = optional(map(string), { Snapshot = "true" })<br>    copy_tags       = optional(bool, false)<br>  }))</pre> | n/a | yes |
| <a name="input_stack_prefix"></a> [stack\_prefix](#input\_stack\_prefix) | Stack Prefix for resource generation | `string` | `"dlm_lifecycle"` | no |
| <a name="input_unique_name"></a> [unique\_name](#input\_unique\_name) | Enter Unique Name to identify the Terraform Stack (lowercase) | `string` | `"v1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Identifier of the DLM Lifecycle Policy |
| <a name="output_policies_arns"></a> [policies\_arns](#output\_policies\_arns) | Amazon Resource Name (ARN) of the DLM Lifecycle Policy |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related documentation

AWS DLM Lifecycle Policy: [terraform.io/docs/providers/aws/r/dlm_lifecycle_policy](https://www.terraform.io/docs/providers/aws/r/dlm_lifecycle_policy)
