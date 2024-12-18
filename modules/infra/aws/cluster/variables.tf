variable "deployment_id" {
  type = string
}

variable "owner" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  description = "Public subnets"
  type = list(any)
}
variable "private_subnets" {
  description = "Private subnets"
  type = list(any)
}

variable "instance_type" {
  type = string
}

variable "controller_db_username" {
  type = string
}

variable "controller_db_password" {
  type = string
}

variable "controller_count" {
  type = number
}

variable "route53_boundary_hosted_zone_name" {
  type = string
}

variable "route53_hosted_zone" {
  type = string
}

variable "controller_cert" {
  type = string
}

variable "controller_private_key" {
  type = string
}

variable "ca_cert" {
  type = string
}