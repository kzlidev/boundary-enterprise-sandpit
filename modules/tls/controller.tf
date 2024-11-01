# Create private key for controller certificate
resource "tls_private_key" "controller_private_key" {
  algorithm = "RSA"
}

resource "local_file" "controller_private_key" {
  content  = tls_private_key.controller_private_key.private_key_pem
  filename = "${path.root}/tmp/tls/controller_private_key.key"
}

# Create CSR for for controller certificate 
resource "tls_cert_request" "controller_csr" {

  private_key_pem = tls_private_key.controller_private_key.private_key_pem

  dns_names = [var.route53_boundary_hosted_zone_name]

  subject {
    country             = "SG"
    province            = "Singapore"
    locality            = "Singapore"
    common_name         = var.route53_boundary_hosted_zone_name
    organization        = "Demo Organization"
    organizational_unit = "Development"
  }
}

# Sign Seerver Certificate by Private CA 
resource "tls_locally_signed_cert" "controller_signed_cert" {
  // CSR by the controller servers
  cert_request_pem = tls_cert_request.controller_csr.cert_request_pem
  // CA Private key 
  ca_private_key_pem = tls_private_key.ca_private_key.private_key_pem
  // CA certificate
  ca_cert_pem = tls_self_signed_cert.ca_cert.cert_pem

  validity_period_hours = 4380

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]
}

resource "local_file" "controller_cert" {
  content  = tls_locally_signed_cert.controller_signed_cert.cert_pem
  filename = "${path.root}/tmp/tls/controller.cert"
}
