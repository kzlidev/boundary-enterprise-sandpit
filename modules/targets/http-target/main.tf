data "aws_ami" "an_image" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "name"
    values = ["${var.owner}-hashicats*"]
  }
}

# data "aws_ami" "ubuntu" {
#   most_recent = true
#
#   filter {
#     name = "name"
#     #values = ["ubuntu/images/hvm-ssd/ubuntu-disco-19.04-amd64-server-*"]
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
#
#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
#
#   owners = ["099720109477"] # Canonical
# }

resource "aws_eip" "hashicat" {
  instance = aws_instance.hashicat.id
  vpc      = true
}

resource "aws_eip_association" "hashicat" {
  instance_id   = aws_instance.hashicat.id
  allocation_id = aws_eip.hashicat.id
}

resource "aws_instance" "hashicat" {
  ami           = data.aws_ami.an_image.id
  instance_type = var.instance_type
  key_name      = var.infra_aws.aws_keypair_key_name
  subnet_id     = var.infra_aws.private_subnets[0]
  vpc_security_group_ids = [module.private-http-inbound.security_group_id]

  tags = {
    Name       = "${var.prefix}-hashicat-instance"
    Department = "IT"
    Billable   = 100
  }
}

# resource "tls_private_key" "hashicat" {
#   algorithm = "ED25519"
# }
#
# locals {
#   private_key_filename = "${var.prefix}-ssh-key.pem"
# }
#
# resource "aws_key_pair" "hashicat" {
#   key_name   = local.private_key_filename
#   public_key = tls_private_key.hashicat.public_key_openssh
# }

