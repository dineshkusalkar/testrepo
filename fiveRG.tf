provider "azurerm" {
  features {}

   client_id       = "e07a0559-302b-4654-9640-9145e07e147f"
  client_secret   = "AV58Q~XHcqemh5k.E9cNSFojhM3PX5M1qALYwcJm"
  tenant_id       = "483664c7-2998-4342-8915-dcd611c2fefe"
  subscription_id = "7c2ed10b-da64-4ca3-8747-92f46fa59d9a"
}



# create 5 Resource Group  o/p like ---> dinesh0 , dinesh1, .....dinesh4

resource "azurerm_resource_group" "example" {

  name = "dinesh${count.index}"   ## dinesh0 , dinesh1, .....dinesh4 
  location = "eastus"
  count = 5
}
####################################################################################
# craete 4 Resource Group with the help of list

variable "self_name" {
  type = list
    default = ["rahul","ganesh","kasar","sali"]
}

resource "azurerm_resource_group" "example1" {
  
  name = var.self_name[count.index]
  location = "eastus"
  count=4
}


############################################################################################
# craet  3 ip in one resource group

variable "self_ip_name" {
  type = list
    default = ["din1","din2","din3"]
}

resource "azurerm_resource_group" "localdinesh" {
  
  name = "chandrakant"
  location = "westus"

}

resource "azurerm_public_ip" "mypip" {
  name                = var.self_ip_name[count.index]                         
  resource_group_name = azurerm_resource_group.localdinesh.name
  location            = azurerm_resource_group.localdinesh.location
  allocation_method   = "Static"

  count = 3
}


############################################################################################
# craet  output block show all the ip address


output "mypips" {
  
  value = azurerm_public_ip.mypip[*].ip_address
  # value = azurerm_public_ip.mypip[*].name
}
