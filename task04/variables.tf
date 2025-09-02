variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "rg_name" {
  description = "RG Name"
  type        = string
}

variable "vnet_name" {
  description = "VNet name"
  type        = string
}

variable "nic_name" {
  description = "Network interface name."
  type        = string
}


variable "nsg_name" {
  description = "Network Security Group name."
  type        = string
}


variable "nsg_rule_http" {
  description = "NSG inbound rule name for HTTP."
  type        = string
}


variable "nsg_rule_ssh" {
  description = "NSG inbound rule name for SSH."
  type        = string
}


variable "public_ip" {
  description = "Public IP resource name."
  type        = string
}


variable "domain_name_label" {
  description = "DNS name label for the Public IP"
  type        = string
}


variable "vm_name" {
  description = "Linux VM name."
  type        = string
}


variable "vm_os_version" {
  description = "Linux OS version"
  type        = string
}


variable "vm_SKU" {
  description = "VM size"
  type        = string
}


variable "student_email" {
  description = "Value for the Creator tag."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM."
  type        = string
}


variable "vm_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "vnet_address_space" {
  description = "VNet CIDR address space."
  type        = string
}


variable "subnet_prefix" {
  description = "Subnet CIDR prefix."
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to required resources."
  type        = map(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}
