# Create Linux Host for Testing

# Creating Storage Account for Boot Diagnostics for Serial Console access to the ubuntu host

resource "azurerm_storage_account" "appastrgacc" {
  name                          = "sknapp1host1"
  resource_group_name           = "${var.rg_name}"
  location                      = "${var.location}"
  account_replication_type      = "LRS"
  account_tier                  = "Standard"
  depends_on                    = ["azurerm_resource_group.rg"]
}


# Create test host app1-host1
resource "azurerm_virtual_machine" "app1-host1" {
  name                  = "app1-host1"
  location              = "${var.location}"
  resource_group_name   = "${var.rg_name}"
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "app1-host1-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "app1-host1"
    admin_username = "${var.adminUsername}"
    admin_password = "${var.adminPassword}"
  }

  network_interface_ids = ["${azurerm_network_interface.app1-host1-nic0.id}"]

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.appastrgacc.primary_blob_endpoint}"
  }
  depends_on                = ["azurerm_network_interface.app1-host1-nic0" , 
                               "azurerm_storage_account.appastrgacc"]
}


# Creating Storage Account for Boot Diagnostics for Serial Console access to the ubuntu host App2

resource "azurerm_storage_account" "appbstrgacc" {
  name                     = "sknapp2host1"
  resource_group_name      = "${var.rg_name}"
  location                 = "${var.location}"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  depends_on                    = ["azurerm_resource_group.rg"]
}


# Create test host app2-host1
resource "azurerm_virtual_machine" "app2-host1" {
  name                  = "app2-host1"
  location              = "${var.location}"
  resource_group_name   = "${var.rg_name}"
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "app2-host1-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "app2-host1"
    admin_username = "${var.adminUsername}"
    admin_password = "${var.adminPassword}"
  }

  network_interface_ids = ["${azurerm_network_interface.app2-host1-nic0.id}"]

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.appbstrgacc.primary_blob_endpoint}"
  }
  depends_on                = ["azurerm_network_interface.app2-host1-nic0" , 
                               "azurerm_storage_account.appbstrgacc"]
}
