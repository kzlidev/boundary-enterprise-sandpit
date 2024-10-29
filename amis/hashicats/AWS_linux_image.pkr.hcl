source "amazon-ebs" "ubuntu-image" {
  ami_name = "${var.owner}-hashicats-{{timestamp}}"
  region = "${var.aws_region}"
  instance_type = var.aws_instance_type
  tags = {
    Name = "${var.owner}-hashicats"
  }
  source_ami_filter {
      filters = {
        virtualization-type = "hvm"
        name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
        // name = "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*"
        root-device-type = "ebs"
      }
      owners = ["099720109477"]
      most_recent = true
  }
  communicator = "ssh"
  ssh_username = "ubuntu"
}

build {
  sources = [
    "source.amazon-ebs.ubuntu-image"
  ]
  /* provisioner "file" {
    source      = "../../files/consul.service"
    destination = "/tmp/consul.service"
  } */
  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"
  }

  provisioner "shell" {
    inline = [
      "sudo apt -y update",
      "sleep 15",
      "sudo apt -y update",
      "sudo apt -y install apache2",
      "sudo systemctl start apache2",
      "sudo chown -R ubuntu:ubuntu /var/www/html",
      "chmod +x *.sh",
      "PLACEHOLDER=${var.placeholder} WIDTH=${var.width} HEIGHT=${var.height} PREFIX=${var.owner} ./deploy_app.sh",
      "sudo apt -y install cowsay",
      "cowsay Mooooooooooo!",
    ]
  }
}
