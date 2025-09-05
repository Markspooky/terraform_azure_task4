resource "azurerm_windows_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id


  site_config {
    # Deny by default anything not matching ip_restriction rules
    ip_restriction_default_action = "Deny"


    dynamic "ip_restriction" {
      for_each = var.allowed_ip_rules
      content {
        name       = ip_restriction.value.name
        action     = "Allow"
        ip_address = ip_restriction.value.ip_address
        priority   = ip_restriction.value.priority
      }
    }


    dynamic "ip_restriction" {
      for_each = var.allow_traffic_manager ? [1] : []
      content {
        name        = "allow-tm"
        action      = "Allow"
        service_tag = "AzureTrafficManager"
        priority    = 200
      }
    }
  }


  tags = var.tags
}
