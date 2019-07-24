# Create availability set for VM-series Firewalls
resource "azurerm_availability_set" "fw-aset" {
	name                         	= "fw-aset"
	location                     	= "${var.location}"
	resource_group_name          	= "${var.rg_name}"
	platform_update_domain_count 	= "2"
  	platform_fault_domain_count  	= "2"
  	managed                      	= "true"
  	depends_on                		= ["azurerm_resource_group.rg"]
}
