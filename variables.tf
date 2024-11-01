variable "deployment_name" {
  type = string
}

variable "owner" {
  description = "Resource owner identified using an email address"
  type        = string
  default     = "rp"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  type        = string
  default     = "10.200.0.0/16"
}

variable "aws_private_subnets" {
  description = "AWS private subnets"
  type        = list(any)
  default     = ["10.200.20.0/24", "10.200.21.0/24", "10.200.22.0/24"]
}

variable "aws_private_subnets_eks" {
  description = "AWS private subnets"
  type        = list(any)
  default     = ["10.200.30.0/24", "10.200.31.0/24", "10.200.32.0/24"]
}

variable "aws_public_subnets" {
  description = "AWS public subnets"
  type        = list(any)
  default     = ["10.200.10.0/24", "10.200.11.0/24", "10.200.12.0/24"]
}

variable "aws_instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t3.micro"
}

variable "controller_db_username" {
  type = string
}

variable "controller_db_password" {
  type = string
}

variable "controller_count" {
  type    = number
  default = 1
}


variable "auth0_domain" {
  type    = string
  default = ""
}

variable "auth0_client_id" {
  type    = string
  default = ""
}

variable "auth0_client_secret" {
  type    = string
  default = ""
}

variable "okta_api_token" {
  type    = string
  default = ""
}
variable "okta_base_url" {
  type    = string
  default = ""
}
variable "okta_domain" {
  type    = string
  default = ""
}
variable "okta_org_name" {
  type    = string
  default = ""
}

variable "user_password" {
  type = string
}

variable "localhost" {
  type    = string
  default = "127.0.0.1"
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "boundary_admin_username" {
  type = string
}
variable "boundary_admin_password" {
  type = string
}

variable "az_ad_tenant_id" {
  type    = string
  default = ""
}

variable "az_ad_client_id" {
  type    = string
  default = ""
}

variable "az_ad_client_secret" {
  type    = string
  default = ""
}

variable "idp_type" {
  type = string
  validation {
    condition     = contains(["azure", "auth0", "okta"], var.idp_type)
    error_message = "The idp_type must be either 'azure', 'auth0' or 'okta'."
  }
}

variable "boundary_version" {
  type = string
}

variable "route53_hosted_zone" {}

variable "route53_boundary_hosted_zone_name" {

}

variable "route53_hashicats_hosted_zone_name" {

}
/* 
variable "rdp_username" {
  type = string
}

variable "rdp_password" {
  type = string
} 
*/
