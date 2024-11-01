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
  vpc_security_group_ids = [module.private-https-inbound.security_group_id]

  tags = {
    Name       = "${var.prefix}-hashicat-instance"
    Department = "IT"
    Billable   = 100
  }

  provisioner "file" {
    content = file("${path.module}/html/hashicats.conf")
    destination = "/tmp/hashicats.conf"
  }

  provisioner "file" {
    content     = var.hashicats_cert
    destination = "/tmp/hashicats.crt"
  }

  provisioner "file" {
    content     = var.hashicats_private_key
    destination = "/tmp/hashicats.key"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo a2enmod ssl",
      "sudo mv /tmp/hashicats.crt /etc/ssl/certs/hashicats.crt",
      "sudo mv /tmp/hashicats.key /etc/ssl/private/hashicats.key",
      "sudo mv /tmp/hashicats.conf /etc/apache2/sites-available/",
      "sudo a2ensite hashicats.conf",
      "sudo systemctl restart apache2"
    ]
  }

  connection {
    bastion_host        = var.bastion_public_ip
    bastion_user        = "ubuntu"
    agent               = false
    bastion_private_key = var.ssh_private_key

    host        = self.private_ip
    user        = "ubuntu"
    private_key = var.ssh_private_key
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

