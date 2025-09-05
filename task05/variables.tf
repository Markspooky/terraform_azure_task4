variable "tags" {
  description = "Common tags applied to all required resources"
  type        = map(string)
}


variable "resource_groups" {
  description = "Resource groups to create (unique locations required)"
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}


variable "workloads" {
  description = "Map of workloads: each defines an App Service Plan and a Windows Web App in a specific RG"
  type = map(object({
    rg_key = string # key into var.resource_groups
    plan = object({
      name         = string
      sku_name     = string
      worker_count = number
    })
    app = object({
      name = string
    })
  }))
}


variable "verification_ip" {
  description = "Verification agent IPv4 CIDR to allow"
  type        = string
}


variable "traffic_manager" {
  description = "Traffic Manager profile settings"
  type = object({
    rg_key         = string
    name           = string
    routing_method = string
  })
}
