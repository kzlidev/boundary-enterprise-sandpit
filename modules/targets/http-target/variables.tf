variable "prefix" {
  description = "This prefix will be included in the name of most resources."
}

variable "owner" {
  type = string
}

variable "region" {
  description = "The region where the resources are created."
  default     = "ap-southeast-1"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}

variable "admin_username" {
  description = "Administrator user name for mysql"
  default     = "hashicorp"
}

variable "infra_aws" {
  type = object({
    vpc_cidr_block                   = string
    vpc_id                           = string
    public_subnets = list(string)
    private_subnets = list(string)
    aws_keypair_key_name             = string
    controller_internal_dns          = string
    bastion_ip                       = string
    vault_ip                         = string
    bastion_security_group_id        = string
    vault_security_group_id          = string
    worker_ingress_security_group_id = string
    worker_egress_security_group_id  = string
    boundary_cluster_url             = string
    worker_instance_profile          = string
    session_storage_role_arn         = string
  })
}

variable "boundary_resources" {
  type = object({
    org_id              = string
    project_id          = string
    static_credstore_id = string
  })
}
