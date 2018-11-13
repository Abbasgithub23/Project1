# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = "${var.access_subscriptid}"
    client_id       = "${var.access_appid}"
    client_secret   = "${var.access_clientsecret}"
    tenant_id       = "${var.access_tenantid}"
}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "demo-rg"
    location = "${var.access_location}"

    tags {
        environment = "TESTING"
    }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "demo-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.access_location}"
    resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"

    tags {
        environment = "TESTING"
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "demo-subnet"
    resource_group_name  = "${azurerm_resource_group.myterraformgroup.name}"
    virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
    address_prefix       = "10.0.1.0/24"
}