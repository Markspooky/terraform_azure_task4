locals {
  rg_map = var.resource_groups
}

module "resource_groups" {
  for_each = var.resource_groups
  source   = "./modules/resource_group"


  name     = each.value.name
  location = each.value.location
  tags     = merge(each.value.tags, var.tags)
}

module "plans" {
  for_each = var.workloads
  source   = "./modules/app_service_plan"


  name                = each.value.plan.name
  location            = module.resource_groups[each.value.rg_key].location
  resource_group_name = module.resource_groups[each.value.rg_key].name
  sku_name            = each.value.plan.sku_name
  worker_count        = each.value.plan.worker_count
  tags                = var.tags
}

module "apps" {
  for_each = var.workloads
  source   = "./modules/app_service"


  name                = each.value.app.name
  location            = module.resource_groups[each.value.rg_key].location
  resource_group_name = module.resource_groups[each.value.rg_key].name
  service_plan_id     = module.plans[each.key].id


  allowed_ip_rules = [
    {
      name       = "allow-ip"
      ip_address = var.verification_ip
      priority   = 100
    }
  ]
  allow_traffic_manager = true
  tags                  = var.tags
}

module "traffic_manager" {
  source = "./modules/traffic_manager"


  name                = var.traffic_manager.name
  resource_group_name = module.resource_groups[var.traffic_manager.rg_key].name
  location            = module.resource_groups[var.traffic_manager.rg_key].location
  routing_method      = var.traffic_manager.routing_method
  tags                = var.tags


  endpoints = {
    for k, v in module.apps : k => {
      name               = "${v.name}-ep"
      target_resource_id = v.id
      endpoint_location  = v.location
    }
  }
}
