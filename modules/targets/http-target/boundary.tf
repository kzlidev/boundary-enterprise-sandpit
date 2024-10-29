resource "boundary_host_catalog_static" "http_server" {
  name        = "http_servers"
  description = "http servers"
  scope_id    = var.boundary_resources.project_id
}

resource "boundary_host_static" "http_servers" {
  name            = "http_server_1"
  description     = "HTTP Instance #1"
  address         = aws_instance.hashicat.private_ip
  host_catalog_id = boundary_host_catalog_static.http_server.id
}

resource "boundary_host_set_static" "http_servers" {
  name            = "http_host_set"
  description     = "Host set for HTTP servers"
  host_catalog_id = boundary_host_catalog_static.http_server.id
  host_ids = [boundary_host_static.http_servers.id]
}

resource "boundary_role" "http_user" {
  name        = "http_user"
  description = "Access to http hosts for user role"
  scope_id    = var.boundary_resources.org_id
  grant_scope_ids = [var.boundary_resources.project_id]
  grant_strings = [
    "ids=${boundary_target.http_user.id};actions=read,authorize-session",
    "ids=${boundary_host_static.http_servers.id};actions=read",
    "ids=${boundary_host_set_static.http_servers.id};actions=read",
    "ids=*;type=target;actions=list,no-op",
    "ids=*;type=auth-token;actions=list,read:self,delete:self"
  ]
  principal_ids = [
    file("${path.root}/generated/managed_group_analyst_id"), file("${path.root}/generated/managed_group_admin_id")
  ]
}

resource "boundary_target" "http_user" {
  type                     = "tcp"
  name                     = "http_user"
  description              = "HTTP host access for user"
  scope_id                 = var.boundary_resources.project_id
  session_connection_limit = -1
  default_port             = 3389
  ingress_worker_filter    = "\"ingress\" in \"/tags/type\""
  egress_worker_filter     = "\"egress\" in \"/tags/type\""
  host_source_ids = [
    boundary_host_set_static.http_servers.id
  ]

  # brokered_credential_source_ids = [ boundary_credential_username_password.static_win_creds.id ]

}

# resource "boundary_credential_username_password" "static_win_creds" {
#   name                = "static_windows_creds"
#   description         = "Windows credentials"
#   credential_store_id = var.boundary_resources.static_credstore_id
#   username            = "Administrator"
#   password            = rsadecrypt(aws_instance.windows.password_data, file("${path.root}/generated/rsa_key"))
# }
