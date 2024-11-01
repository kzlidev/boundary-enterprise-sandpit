module "private-https-inbound" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.prefix}-private-http"
  description = "Allow HTTP/S private inbound"
  vpc_id      = var.infra_aws.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = var.infra_aws.worker_egress_security_group_id
    },
    {
      rule                     = "http-80-tcp"
      source_security_group_id = var.infra_aws.bastion_security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = var.infra_aws.worker_egress_security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = var.infra_aws.worker_egress_security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = var.infra_aws.worker_ingress_security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = var.infra_aws.bastion_security_group_id
    },
  ]

  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}