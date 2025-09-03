location = "eastus"

rg_name           = "cmaz-zz733vvq-mod4-rg"
vnet_name         = "cmaz-zz733vvq-mod4-vnet"
subnet_name       = "frontend"
nic_name          = "cmaz-zz733vvq-mod4-nic"
nsg_name          = "cmaz-zz733vvq-mod4-nsg"
nsg_rule_http     = "AllowHTTP"
nsg_rule_ssh      = "AllowSSH"
public_ip         = "cmaz-zz733vvq-mod4-pip"
domain_name_label = "cmaz-zz733vvq-mod4-nginx"
vm_name           = "cmaz-zz733vvq-mod4-vm"
vm_os_version     = "24_04-lts"
vm_SKU            = "Standard_F2s_v2"
student_email     = "mark_nagy@epam.com"

admin_username = "terraformmark-sp"


vnet_address_space = "10.10.0.0/16"
subnet_prefix      = "10.10.1.0/24"

common_tags = {
  Environment = "dev"
  Project     = "task04"
}
