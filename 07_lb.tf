# Create an East-West load balancer

resource "azurerm_lb" "ewlb" {
  name                            = "ewlb"
  location                        = "${var.location}"
  resource_group_name             = "${var.rg_name}"
  sku                             = "Standard"

  frontend_ip_configuration {
    name                          = "ewlb-fe"
    private_ip_address_allocation = "Static"
    subnet_id                     = "${azurerm_subnet.trust.id}"
    private_ip_address            = "${var.ewlb_FE_address}"
  }
  depends_on                      = ["azurerm_resource_group.rg" ,
                                     "azurerm_subnet.trust"]
}

# Create back end pool
resource "azurerm_lb_backend_address_pool" "ewlb-bp" {
  resource_group_name             = "${var.rg_name}"
  loadbalancer_id                 = "${azurerm_lb.ewlb.id}"
  name                            = "fw-trust-pool"
  depends_on                      = ["azurerm_resource_group.rg" ,
                                     "azurerm_lb.ewlb"]
} 


# Create a LB probe
resource "azurerm_lb_probe" "ewlb-probe" {
  resource_group_name             = "${var.rg_name}"
  loadbalancer_id                 = "${azurerm_lb.ewlb.id}"
  name                            = "HTTPS-Probe"
  protocol                        = "TCP"
  port                            = 443
  interval_in_seconds             = 5
  number_of_probes 	              = 2
  depends_on                      = ["azurerm_lb.ewlb"]
}

# Create LB Rules
resource "azurerm_lb_rule" "ewlb-lbr" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${azurerm_lb.ewlb.id}"
  name                           = "EW-LBR"
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "ewlb-fe"
  backend_address_pool_id	       = "${azurerm_lb_backend_address_pool.ewlb-bp.id}"
  probe_id                       = "${azurerm_lb_probe.ewlb-probe.id}"
  load_distribution			         = "Default"
  enable_floating_ip             = "true"
  depends_on                      = ["azurerm_lb_backend_address_pool.ewlb-bp" ,
                                     "azurerm_lb.ewlb" ,
                                     "azurerm_lb_probe.ewlb-probe"]
}
