#
# Create FW1 in the EW-Skillet VNet
#
resource "azurerm_virtual_machine" "FW1" {
  name                  = "PA-FW1"
  location              = "${var.location}"
  resource_group_name   = "${var.rg_name}"
  vm_size               = "${var.instancetype}"
  availability_set_id		= "${azurerm_availability_set.fw-aset.id}"
  
  delete_os_disk_on_termination = true
  
  plan {
    name      = "${var.instanceSku}"
    publisher = "paloaltonetworks"
    product   = "vmseries1"
  }

  storage_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries1"
    sku       = "${var.instanceSku}"
    version   = "${var.instanceVersion}"
  }

  storage_os_disk {
    name              = "FW1-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "PA-FW1"
    admin_username = "${var.adminUsername}"
    admin_password = "${var.adminPassword}"
    custom_data     = "storage-account=${var.bootstrap_sa1},access-key=${var.sa_key1},file-share=${var.file_share1},share-directory=${var.share_dir1}"
  }

  primary_network_interface_id = "${azurerm_network_interface.FW1-nic0.id}"
  
  network_interface_ids = ["${azurerm_network_interface.FW1-nic0.id}",
                           "${azurerm_network_interface.FW1-nic1.id}",
                          ]

  os_profile_linux_config {
    disable_password_authentication = false
  }
  depends_on                = ["azurerm_network_interface.FW1-nic0" , 
                               "azurerm_network_interface.FW1-nic1" ,
                               "azurerm_availability_set.fw-aset"]
}

# Create FW2 in the EW-Skillet VNet
resource "azurerm_virtual_machine" "FW2" {
  name                  = "PA-FW2"
  location              = "${var.location}"
  resource_group_name   = "${var.rg_name}"
  vm_size               = "${var.instancetype}"
  availability_set_id		= "${azurerm_availability_set.fw-aset.id}"
  
  delete_os_disk_on_termination = true
  
  plan {
    name      = "${var.instanceSku}"
    publisher = "paloaltonetworks"
    product   = "vmseries1"
  }

  storage_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries1"
    sku       = "${var.instanceSku}"
    version   = "${var.instanceVersion}"
  }

  storage_os_disk {
    name              = "FW2-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "PA-FW2"
    admin_username = "${var.adminUsername}"
    admin_password = "${var.adminPassword}"
    custom_data     = "storage-account=${var.bootstrap_sa2},access-key=${var.sa_key2},file-share=${var.file_share2},share-directory=${var.share_dir2}"
  }

  primary_network_interface_id = "${azurerm_network_interface.FW2-nic0.id}"
  
  network_interface_ids = ["${azurerm_network_interface.FW2-nic0.id}",
                           "${azurerm_network_interface.FW2-nic1.id}",
                          ]

  os_profile_linux_config {
    disable_password_authentication = false
  }
  depends_on                = ["azurerm_network_interface.FW2-nic0" , 
                               "azurerm_network_interface.FW2-nic1" ,
                               "azurerm_availability_set.fw-aset"]
}