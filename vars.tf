# List Valriables used in the Terraform Script files
variable "sub_id" {
    default = ""
}
variable "clnt_id" {
    default = ""
}
variable "clnt_sec" {
    default = ""
}
variable "tnt_id" {
    default = ""
}
variable "rg_name" {}
variable "location" {
    default = "West India"
}
variable "vnet_name" {}
variable "cidr" {}
variable "ewlb_FE_address" {}
variable "mgmtSubnetName" {}
variable "mgmtSubnet" {}
variable "trustSubnetName" {}
variable "trustSubnet" {}
variable "app1SubnetName" {}
variable "app1Subnet" {}
variable "app2SubnetName" {}
variable "app2Subnet" {}
variable "instancetype" {}
variable "instanceSku" {}
variable "instanceVersion" {}
variable "bootstrap_sa1" {
    default = ""
}
variable "sa_key1" {
    default = ""
}
variable "file_share1" {
    default = ""
}
variable "share_dir1" {}
variable "bootstrap_sa2" {
    default = ""
}
variable "sa_key2" {
    default = ""
}
variable "file_share2" {
    default = ""
}
variable "share_dir2" {}
variable "adminUsername" {}
variable "adminPassword" {}
variable "mysourceip" {
    default = ""
}
