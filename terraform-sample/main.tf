locals {
  project_name = "ballast-examples-terraform"
}

output "project_name" {
  description = "Example output for the ballast-examples Terraform smoke sample."
  value       = local.project_name
}
