#Create subnets in VNet

#Create management subnets for Firewalls
resource "azurerm_subnet" "mgmt" {
    name                      = "${var.mgmtSubnetName}"
    resource_group_name       = "${var.rg_name}"
    address_prefix            = "${var.mgmtSubnet}"
    virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
    network_security_group_id = "${azurerm_network_security_group.mgmt-nsg.id}"
    depends_on                = ["azurerm_virtual_network.vnet" ,
                                 "azurerm_network_security_group.FwInt-Nsg"]
}

#Create trust subnets for Firewalls
resource "azurerm_subnet" "trust" {
    name                      = "${var.trustSubnetName}"
    resource_group_name       = "${var.rg_name}"
    address_prefix            = "${var.trustSubnet}"
    virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
    network_security_group_id = "${azurerm_network_security_group.FwInt-Nsg.id}"
    depends_on                = ["azurerm_virtual_network.vnet" ,
                                 "azurerm_network_security_group.FwInt-Nsg"]
}

#Create subnets for APP1-Host
resource "azurerm_subnet" "app1" {
    name                      = "${var.app1SubnetName}"
    resource_group_name       = "${var.rg_name}"
    address_prefix            = "${var.app1Subnet}"
    virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
    network_security_group_id = "${azurerm_network_security_group.App-Nsg.id}"
    route_table_id            = "${azurerm_route_table.app1RT.id}"
    depends_on                = ["azurerm_virtual_network.vnet" ,
                                 "azurerm_route_table.app1RT" ,
                                 "azurerm_network_security_group.App-Nsg" ]
}

#Create subnets for APP2-Host
resource "azurerm_subnet" "app2" {
    name                      = "${var.app2SubnetName}"
    resource_group_name       = "${var.rg_name}"
    address_prefix            = "${var.app2Subnet}"
    virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
    network_security_group_id = "${azurerm_network_security_group.App-Nsg.id}"
    route_table_id            = "${azurerm_route_table.app2RT.id}"
    depends_on                = ["azurerm_virtual_network.vnet" ,
                                 "azurerm_route_table.app2RT" ,
                                 "azurerm_network_security_group.App-Nsg" ]
}