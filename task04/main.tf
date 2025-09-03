locals {
  nic_ip_config_name = "${var.nic_name}-ipconfig"
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
  tags = merge(var.common_tags, {
    Creator = var.student_email
  })
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_address_space]
  tags = merge(var.common_tags, {
    Creator = var.student_email
  })
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_public_ip" "pip" {
  name                = var.public_ip
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.domain_name_label
  tags = merge(var.common_tags, {
    Creator = var.student_email
  })
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(var.common_tags, {
    Creator = var.student_email
  })
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = var.nsg_rule_ssh
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "0.0.0.0/0"
}

resource "azurerm_network_security_rule" "http" {
  name                        = var.nsg_rule_http
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "0.0.0.0/0"
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = local.nic_ip_config_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = merge(var.common_tags, {
    Creator = var.student_email
  })
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_SKU
  admin_username                  = var.admin_username
  admin_password                  = var.vm_password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.nic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name = var.vm_name

  tags = merge(var.common_tags, {
    Creator = var.student_email
  })

  depends_on = [
    azurerm_network_interface_security_group_association.nic_nsg,
    azurerm_network_security_rule.ssh,
    azurerm_public_ip.pip
  ]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]

    connection {
      type     = "ssh"
      host     = azurerm_public_ip.pip.ip_address
      user     = var.admin_username
      password = var.vm_password
      timeout  = "5m"
    }
  }
}
