# AWS DLM Lifecycle (Data Lifecycle Manager)

This terraform module is designed to help in using the AWS DLM Lifecycle. Each
volume that needs to be supported by the DLM Lifecycle must be tagged with
`Snapshot = "true"`.

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
| <a name="input_dlm_policies"></a> [dlm\_policies](#input\_dlm\_policies) | DLM Policies to be created | `list(map(string))` | n/a | yes |
| <a name="input_stack_prefix"></a> [stack\_prefix](#input\_stack\_prefix) | Stack Prefix for resource generation | `string` | `"dlm_lifecycle"` | no |
| <a name="input_target_tags"></a> [target\_tags](#input\_target\_tags) | A map of tag keys and their values. Any resources that match the resource\_types and are tagged with any of these tags will be targeted. | `map(string)` | <pre>{<br>  "Snapshot": "true"<br>}</pre> | no |
| <a name="input_unique_name"></a> [unique\_name](#input\_unique\_name) | Enter Unique Name to identify the Terraform Stack (lowercase) | `string` | `"v1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Identifier of the DLM Lifecycle Policy |
| <a name="output_policies_arns"></a> [policies\_arns](#output\_policies\_arns) | Amazon Resource Name (ARN) of the DLM Lifecycle Policy |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related documentation

AWS DLM Lifecycle Policy: [terraform.io/docs/providers/aws/r/dlm_lifecycle_policy](https://www.terraform.io/docs/providers/aws/r/dlm_lifecycle_policy)
