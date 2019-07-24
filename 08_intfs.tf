# Create Public IP Addresses for Firewall-1 mangement interface
resource "azurerm_public_ip" "mgmtPIP_0" {
  name                         = "fw1-mgmt-${random_id.randomId.hex}"
  location                     = "${var.location}"
  resource_group_name          = "${var.rg_name}"
  allocation_method            = "Static"
  domain_name_label            = "fw1-mgmt-${random_id.randomId.hex}"
  sku                          = "Standard"
  depends_on                   = ["random_id.randomId" ,
                                  "azurerm_resource_group.rg"]
}


# Create Interfaces for VM-FW1
resource "azurerm_network_interface" "FW1-nic0" {
  name                = "FW1-Mgmt-Int"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  ip_configuration {
    name                          = "ipconfig0"
    subnet_id                     = "${azurerm_subnet.mgmt.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "192.168.1.4"
    primary                       = "true" 
    public_ip_address_id          = "${azurerm_public_ip.mgmtPIP_0.id}"
  }
  depends_on                      = ["azurerm_subnet.mgmt" ,
                                     "azurerm_public_ip.mgmtPIP_0"]
}


resource "azurerm_network_interface" "FW1-nic1" {
  name                 = "Fw1-Trust-Int"
  location             = "${var.location}"
  resource_group_name  = "${var.rg_name}"
  enable_ip_forwarding = "true"

  ip_configuration {
    name                                    = "ipconfig0"
    subnet_id                               = "${azurerm_subnet.trust.id}"
    private_ip_address_allocation           = "static"
    private_ip_address                      = "192.168.2.4"
  }
  depends_on                      = ["azurerm_subnet.trust" ]
}


resource "azurerm_network_interface_backend_address_pool_association" "fw1ewlb-bp" {
  network_interface_id                      = "${azurerm_network_interface.FW1-nic1.id}"
  ip_configuration_name                     = "ipconfig0"
  backend_address_pool_id                   = "${azurerm_lb_backend_address_pool.ewlb-bp.id}"
  depends_on                                = ["azurerm_network_interface.FW1-nic1" ,
                                               "azurerm_lb_backend_address_pool.ewlb-bp"]
}


# Create Public IP Addresses for Firewall-2 mangement interface
resource "azurerm_public_ip" "mgmtPIP_1" {
  name                                      = "fw2-mgmt-${random_id.randomId.hex}"
  location                                  = "${var.location}"
  resource_group_name                       = "${var.rg_name}"
  allocation_method                         = "Static"
  domain_name_label                         = "fw2-mgmt-${random_id.randomId.hex}"
  sku                                       = "Standard"
  depends_on                                = ["random_id.randomId" ,
                                               "azurerm_resource_group.rg"]
}


# Create Interfaces for VM-fw2
resource "azurerm_network_interface" "FW2-nic0" {
  name                                      = "FW2-Mgmt-Int"
  location                                  = "${var.location}"
  resource_group_name                       = "${var.rg_name}"

  ip_configuration {
    name                                    = "ipconfig0"
    subnet_id                               = "${azurerm_subnet.mgmt.id}"
    private_ip_address_allocation           = "static"
    private_ip_address                      = "192.168.1.5"
    primary                                 = "true" 
    public_ip_address_id                    = "${azurerm_public_ip.mgmtPIP_1.id}"
  }
  depends_on                                = ["azurerm_subnet.mgmt" ,
                                               "azurerm_public_ip.mgmtPIP_1"]
}


resource "azurerm_network_interface" "FW2-nic1" {
  name                                      = "Fw2-Trust-Int"
  location                                  = "${var.location}"
  resource_group_name                       = "${var.rg_name}"
  enable_ip_forwarding                      = "true"

  ip_configuration {
    name                                    = "ipconfig0"
    subnet_id                               = "${azurerm_subnet.trust.id}"
    private_ip_address_allocation           = "static"
    private_ip_address                      = "192.168.2.5"
  }
  depends_on                                = ["azurerm_subnet.trust"]
}

resource "azurerm_network_interface_backend_address_pool_association" "fw2ewlb-bp" {
  network_interface_id                      = "${azurerm_network_interface.FW2-nic1.id}"
  ip_configuration_name                     = "ipconfig0"
  backend_address_pool_id                   = "${azurerm_lb_backend_address_pool.ewlb-bp.id}"
  depends_on                                = ["azurerm_network_interface.FW1-nic1" ,
                                               "azurerm_lb_backend_address_pool.ewlb-bp"]
}

# Create Public IP Addresses for APP-1 Server
resource "azurerm_public_ip" "app1PIP_0" {
  name                         = "app1-${random_id.randomId.hex}"
  location                     = "${var.location}"
  resource_group_name          = "${var.rg_name}"
  allocation_method            = "Dynamic"
  domain_name_label            = "app1-${random_id.randomId.hex}"
  depends_on                   = ["random_id.randomId" ,
                                  "azurerm_resource_group.rg"]
}


# Create Interfaces for test Host1-App1
resource "azurerm_network_interface" "app1-host1-nic0" {
  name                                      = "app1-host1-nic0"
  location                                  = "${var.location}"
  resource_group_name                       = "${var.rg_name}"

  ip_configuration {
    name                                    = "ipconfig0"
    subnet_id                               = "${azurerm_subnet.app1.id}"
    private_ip_address_allocation           = "static"
    private_ip_address                      = "192.168.11.4"
    public_ip_address_id                    = "${azurerm_public_ip.app1PIP_0.id}"
  }
  depends_on                                = ["azurerm_subnet.app1" , 
                                               "azurerm_public_ip.app1PIP_0"]
}

# Create Public IP Addresses for APP-2 Server
resource "azurerm_public_ip" "app2PIP_0" {
  name                         = "app2-${random_id.randomId.hex}"
  location                     = "${var.location}"
  resource_group_name          = "${var.rg_name}"
  allocation_method            = "Dynamic"
  domain_name_label            = "app2-${random_id.randomId.hex}"
  depends_on                   = ["random_id.randomId" ,
                                  "azurerm_resource_group.rg"]
}


# Create Interfaces for test Host1-App2
resource "azurerm_network_interface" "app2-host1-nic0" {
  name                                      = "app2-host1-nic0"
  location                                  = "${var.location}"
  resource_group_name                       = "${var.rg_name}"

  ip_configuration {
    name                                    = "ipconfig0"
    subnet_id                               = "${azurerm_subnet.app2.id}"
    private_ip_address_allocation           = "static"
    private_ip_address                      = "192.168.22.4"
    public_ip_address_id                    = "${azurerm_public_ip.app2PIP_0.id}"
  }
  depends_on                                = ["azurerm_subnet.app2" , 
                                               "azurerm_public_ip.app2PIP_0"]
}
