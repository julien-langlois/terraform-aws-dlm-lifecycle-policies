resource "aws_iam_role" "dlm_lifecycle_role" {
  name               = format("%s-%s-%s", var.stack_prefix, "dlm-lifecycle-role", var.unique_name)
  assume_role_policy = file("${path.module}/files/iam_role.json")
}

resource "aws_iam_role_policy" "dlm_lifecycle" {
  name   = format("%s-%s-%s", var.stack_prefix, "dlm-lifecycle-policies", var.unique_name)
  role   = aws_iam_role.dlm_lifecycle_role.id
  policy = file("${path.module}/files/iam_role_policy.json")
}

resource "aws_dlm_lifecycle_policy" "policies" {
  count = length(var.dlm_policies)

  description        = var.dlm_policies[count.index]["description"]
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = var.dlm_policies[count.index]["state"]

  policy_details {
    resource_types = [var.dlm_policies[count.index]["resource_types"]]
    schedule {
      name = coalesce(var.dlm_policies[count.index]["snapshot_name"], var.dlm_policies[count.index]["description"])

      create_rule {
        cron_expression = var.dlm_policies[count.index]["cron_expression"]
        interval        = var.dlm_policies[count.index]["cron_expression"] != null ? null : var.dlm_policies[count.index]["interval_hours"]
        interval_unit   = var.dlm_policies[count.index]["cron_expression"] != null ? null : "HOURS"
        times           = var.dlm_policies[count.index]["cron_expression"] != null ? null : [var.dlm_policies[count.index]["start_time"]]
      }

      retain_rule {
        count = var.dlm_policies[count.index]["retention_count"]
      }
      tags_to_add = {
        SnapshotCreator = "DLM"
      }
      copy_tags = var.dlm_policies[count.index]["copy_tags"]
    }

    target_tags = var.dlm_policies[count.index]["target_tags"]
  }
}
