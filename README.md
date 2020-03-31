# AWS DLM Lifecycle (Data Lifecycle Manager)

This terraform module is designed to help in using the AWS DLM Lifecycle. Each
volume that needs to be supported by the DLM Lifecycle must be tagged with
`Snapshot = "true"`.

## Requirements

* [AWS Terraform provider](https://www.terraform.io/docs/providers/aws/) >= 2.46

## Usage

```hcl
module "dlm-lifecycle" {
  source = "julien-langlois/dlm-lifecycle-policies/aws"

  dlm_policies = [
    { description = "DLM7", snapshot_name = "Rolling backup 7 days", start_time = "01:00", interval_hours = 4, retention_count = 7 },
    { description = "DLM14", snapshot_name = "Rolling backup 14 days", start_time = "04:00", interval_hours = 12, retention_count = 14 },
    { description = "DLM30", snapshot_name = "Rolling backup 30 days", start_time = "21:00", interval_hours = 2, retention_count = 30 }
  ]
}
```

## Inputs

| Name          | Description                                                   |       Type        |     Default     | Required |
| ------------- | ------------------------------------------------------------- | :---------------: | :-------------: | :------: |
| unique\_name  | Enter Unique Name to identify the Terraform Stack (lowercase) |      string       |      `v1`       |    no    |
| stack\_prefix | Stack Prefix for resource generation                          |      string       | `dlm_lifecycle` |    no    |
| dlm\_policies | Policies to be created                                        | list(map(string)) |       ""        |   yes    |

## Outputs

| Name | Description                                            |
| ---- | ------------------------------------------------------ |
| arn  | Amazon Resource Name (ARN) of the DLM Lifecycle Policy |
| id   | Identifier of the DLM Lifecycle Policy                 |

## Related documentation

AWS DLM Lifecycle Policy: [terraform.io/docs/providers/aws/r/dlm_lifecycle_policy](https://www.terraform.io/docs/providers/aws/r/dlm_lifecycle_policy)