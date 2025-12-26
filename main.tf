

resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.rglocation
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "front" {
  name                 = var.frontsubnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "back" {
  name                 = var.backsubnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = var.dbsubnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "front_ip" {
  name                = var.frontip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "front_nic" {
  name                = var.frontendnic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.front.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.front_ip.id
  }
}

resource "azurerm_network_interface" "back_nic" {
  name                = var.backendnic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.back.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "db_nic" {
  name                = var.dbnic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "frontend_vm" {
  name                = "frontend-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "ayushadmin"
  admin_password      = "Ayush@123456789"
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.front_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                = "backend-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "ayushadmin"
  admin_password      = "Ayush@123456789"
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.back_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


resource "azurerm_mssql_server" "sql_server" {
  name                         = "ayush-sql-server-12345"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = "East Asia"
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "Sql@123456789"
}
resource "azurerm_mssql_database" "sql_db" {
  name      = "ayushappdb"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "Basic"
}
resource "azurerm_mssql_firewall_rule" "allow_backend_subnet" {
  name             = "allow-backend"
  server_id       = azurerm_mssql_server.sql_server.id
  start_ip_address = "10.0.2.0"
  end_ip_address   = "10.0.2.255"
}
