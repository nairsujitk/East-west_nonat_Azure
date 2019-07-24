# Create azure Resource Group
resource "azurerm_resource_group" "rg" {
  name          = "${var.rg_name}"
  location      = "${var.location}"
}

# Creating random string for unique DNS Labels
resource "random_id" "randomId" {
  byte_length   = 8
}
