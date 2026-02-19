resource "azurerm_resource_group" "RG_CP2" {
  name     = "${var.PROJECT_NAME}-rg"
  location = var.LOCATION
  tags     = var.TAGS
}
