output "FW1-MGT-FQDN" {
    value = "${azurerm_public_ip.mgmtPIP_0.fqdn}"
}

output "FW2-MGT-FQDN" {
    value = "${azurerm_public_ip.mgmtPIP_1.fqdn}"
}

output "APP1-FQDN" {
    value = "${azurerm_public_ip.app1PIP_0.fqdn}"
}

output "APP2-FQDN" {
    value = "${azurerm_public_ip.app2PIP_0.fqdn}"
}