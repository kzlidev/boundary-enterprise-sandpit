resource "tls_private_key" "ca_private_key" {
  algorithm = "RSA"
}

resource "local_file" "ca_private_key" {
  content  = tls_private_key.ca_private_key.private_key_pem
  filename = "${path.root}/tmp/tls/ca.key"
}

resource "tls_self_signed_cert" "ca_cert" {
  private_key_pem = tls_private_key.ca_private_key.private_key_pem

  is_ca_certificate = true

  subject {
    country             = "SG"
    province            = "Singapore"
    locality            = "Singapore"
    common_name         = "Demo Boundary Root CA"
    organization        = "Demo Boundary Organization"
    organizational_unit = "Demo Boundary Organization Root Certification Authority"
  }

  validity_period_hours = 4380 // half a year

  allowed_uses = [
    "digital_signature",
    "cert_signing",
    "crl_signing",
  ]
}

resource "local_file" "ca_cert" {
  content  = tls_self_signed_cert.ca_cert.cert_pem
  filename = "${path.root}/tmp/tls/ca.cert"
}