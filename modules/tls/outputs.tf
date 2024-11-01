output "ca_cert" {
  value = tls_self_signed_cert.ca_cert.cert_pem
}

output "ca_private_key" {
  value = tls_private_key.ca_private_key.private_key_pem
}

output "boundary_controller_cert" {
  value = tls_locally_signed_cert.controller_signed_cert.cert_pem
}

output "boundary_controller_private_key" {
  value = tls_private_key.controller_private_key.private_key_pem
}

output "hashicats_https_cert" {
  value = tls_locally_signed_cert.hashicats_signed_cert.cert_pem
}

output "hashicats_https_private_key" {
  value = tls_private_key.hashicats_private_key.private_key_pem
}