locals {
  consul_prefix = var.consul != null ? "${var.consul.prefix}/storage-account/${var.consul.name}" : null
  cmk_key_configuration = var.cmk == null ? null : coalesce(var.cmk.key_configuration, {
    type  = "RSA"
    size  = 4096
    curve = null
    opts  = ["unwrapKey", "wrapKey"]
  })
}
