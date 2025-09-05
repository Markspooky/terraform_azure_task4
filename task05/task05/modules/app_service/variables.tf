variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "service_plan_id" { type = string }

variable "allowed_ip_rules" {
  type = list(object({
    name       = string
    ip_address = string
    priority   = number
  }))
  default = []
}

variable "allow_traffic_manager" {
  type    = bool
  default = true
}


variable "tags" { type = map(string) }
