rg_name = "EW-nonat-skillet"
location = "West India"
vnet_name = "EW-skillet"
cidr = "192.168.0.0/16"
ewlb_FE_address = "192.168.2.250"
mgmtSubnetName = "Management"
mgmtSubnet = "192.168.1.0/24"
trustSubnetName = "Trust"
trustSubnet = "192.168.2.0/24"
app1SubnetName = "App1"
app1Subnet = "192.168.11.0/24"
app2SubnetName = "App2"
app2Subnet = "192.168.22.0/24"
bootstrap = "yes"
instancetype = "Standard_D3_v2"
instanceSku = "byol"
instanceVersion = "latest"
bootstrap_sa1 = "ewsknbootstrapfw1"
sa_key1 = "gep2neAQbvJCc9D0Mm37odRNfblMIh+r7xFJb7di5wf3z+Iw5VIRdzGEb6rLipevy63iyPrBO5kDkIFiY2Jc8A=="
file_share1 = "bootstrap"
share_dir1 = "None"
bootstrap_sa2 = "ewsknbootstrapfw2"
sa_key2 = "ehnnSQ1rrlhtvPGd0YgWRDmaucb8LpPBPASiIk8GnYeDXM4qcm1rMCBGv6VD2TdWkYnxom0VG/ywwdX0qiMi/A=="
file_share2 = "bootstrap"
share_dir2 = "None"
adminUsername = "paloalto"
adminPassword = "Palo@lto123456"