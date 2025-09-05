variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "routing_method" { type = string }
variable "tags" { type = map(string) }

variable "endpoints" {
  description = "Map of endpoints where each value contains fields for the Azure endpoint"
  type = map(object({
    name               = string
    target_resource_id = string
    endpoint_location  = string
  }))
}
