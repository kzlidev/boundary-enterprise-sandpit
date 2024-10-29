
locals {
  digital_channel_org = "digital-channels"
  middleware_org      = "middleware"
  scopes = {
    digital-channels = {
      description = "Digital Channels"
      project = {
        name        = "IT_Support",
        description = "IT Support"
      }
    },
    middleware = {
      description = "Middleware"
      project = {
        name        = "ESB",
        description = "ESB Support"
      }
    }
  }
}

resource "boundary_scope" "global" {
  global_scope = true
  scope_id     = "global"
}

resource "boundary_scope" "org" {
  for_each    = local.scopes
  scope_id    = boundary_scope.global.id
  name        = each.key               //"demo-org"
  description = each.value.description //"Demo Organization"
  // auto_create_admin_role = true
}

resource "boundary_scope" "project" {
  for_each    = local.scopes
  scope_id    = boundary_scope.org[each.key].id
  name        = each.value.project.name
  description = each.value.project.description
  // name        = "IT_Support"
  // description = "IT Support"
  // scope_id    = boundary_scope.org.id 
  // auto_create_admin_role = true 
}
