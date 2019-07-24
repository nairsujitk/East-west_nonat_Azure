# Define the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.sub_id}"
  client_id       = "${var.clnt_id}"
  client_secret   = "${var.clnt_sec}"
  tenant_id       = "${var.tnt_id}"
}