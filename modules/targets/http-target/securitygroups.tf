module "private-http-inbound" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.prefix}-private-http"
  description = "Allow HTTP private inbound"
  vpc_id      = var.infra_aws.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = var.infra_aws.worker_egress_security_group_id
    }
  ]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}