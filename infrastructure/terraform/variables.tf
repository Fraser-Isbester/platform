
variable "billing_account_id" {
  type        = string
  description = "The ID of the billing account to associate this project with."
}

variable "name" {
  type        = string
  description = "The name of the platform deployment."
}

variable "region" {
  type        = string
  description = <<-EOF
    The default region. This is where the control plane is deployed.
    But does not restrict configuration of infrastructure in other regions.
  EOF
}
