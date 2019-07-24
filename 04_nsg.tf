# Create NSG for Management interface
resource "azurerm_network_security_group" "mgmt-nsg" {
  name                        = "mgmt-nsg"
  location                    = "${var.location}"
  resource_group_name         = "${var.rg_name}"

  security_rule {
    name                       = "HTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "${var.mysourceip}"
    destination_address_prefix = "*"
  }
  depends_on                   = ["azurerm_resource_group.rg"]
}

# Create NSG for Firewall Interface's 
resource "azurerm_network_security_group" "FwInt-Nsg" {
  name                         = "FwInt-NSG"
  location                     = "${var.location}"
  resource_group_name          = "${var.rg_name}"

  security_rule {
    name                       = "Allow-All-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-All-Out"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on                   = ["azurerm_resource_group.rg"]
}

# Create NSG for App1 & App2 Subnet's
resource "azurerm_network_security_group" "App-Nsg" {
  name                         = "App-NSG"
  location                     = "${var.location}"
  resource_group_name          = "${var.rg_name}"
  security_rule {
    name                       = "Internet-ssh-2-host"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "${var.mysourceip}"
    destination_address_prefix = "${var.cidr}"
  }
  security_rule {
    name                       = "APP-2-APP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "${var.cidr}"
    destination_address_prefix = "${var.cidr}"
  }
  security_rule {
    name                       = "App2-to-App1"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "${var.cidr}"
    destination_address_prefix = "${var.cidr}"
  }
  depends_on                   = ["azurerm_resource_group.rg"]
}
