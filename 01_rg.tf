# Create azure resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.location}"
}

# Creating random string for use in DNS Labels and Storage Account
resource "random_id" "randomId" {
  keepers = {
      # Generate a new ID only when a new resource group is defined
      resource_group = "${var.rg_name}"
  }
  byte_length = 8
}