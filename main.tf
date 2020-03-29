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

  description        = lookup(var.dlm_policies[count.index], "description", "Snapshot Lifecycle Policy ${count.index}")
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = lookup(var.dlm_policies[count.index], "state", "ENABLED")

  policy_details {
    resource_types = [lookup(var.dlm_policies[count.index], "resource_types", "VOLUME")]
    schedule {
      name = lookup(var.dlm_policies[count.index], "snapshot_name", "Schedule ${count.index}")

      create_rule {
        interval      = lookup(var.dlm_policies[count.index], "interval_hours", 24)
        interval_unit = "HOURS"
        times         = [lookup(var.dlm_policies[count.index], "start_time", "03:00")]
      }
      retain_rule {
        count = lookup(var.dlm_policies[count.index], "retention_count", 7)
      }
      tags_to_add = {
        SnapshotCreator = "DLM"
      }
      copy_tags = lookup(var.dlm_policies[count.index], "copy_tags", false)
    }

    target_tags = {
      Snapshot = "true"
    }
  }
}
