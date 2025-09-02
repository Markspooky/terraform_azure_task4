output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.pip.ip_address
}


output "vm_fqdn" {
  description = "FQDN of the VM"
  value       = azurerm_public_ip.pip.fqdn
}
