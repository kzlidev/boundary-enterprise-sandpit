# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

data "aws_route53_zone" "root" {
  name         = var.route53_hosted_zone
  private_zone = false
}

resource "aws_route53_record" "boundary_record" {
  name    = var.route53_boundary_hosted_zone_name
  zone_id = data.aws_route53_zone.root.zone_id

  type = "A"

  alias {
    name                   = aws_lb.controller_lb.dns_name
    zone_id                = aws_lb.controller_lb.zone_id
    evaluate_target_health = true
  }
}