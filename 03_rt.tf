# Create UDR to route traffic to intenal LB for East <-> West traffic flow

resource "azurerm_route_table" "app1RT" {
  name                      = "${var.app1SubnetName}-RT"
  resource_group_name       = "${var.rg_name}"
  location                  = "${var.location}"

  route {
    name                    = "TO-LB"
    address_prefix          = "192.168.0.0/16"
    next_hop_type           = "VirtualAppliance"
    next_hop_in_ip_address  = "${var.ewlb_FE_address}"
  }

  depends_on = ["azurerm_resource_group.rg"]
}

resource "azurerm_route_table" "app2RT" {
  name                      = "${var.app2SubnetName}-RT"
  resource_group_name       = "${var.rg_name}"
  location                  = "${var.location}"

  route {
    name                    = "TO-LB"
    address_prefix          = "192.168.0.0/16"
    next_hop_type           = "VirtualAppliance"
    next_hop_in_ip_address  = "${var.ewlb_FE_address}"
  }

  depends_on = ["azurerm_resource_group.rg"]
}
