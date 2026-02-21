/**
 * acr.tf
 * ------
 * Azure Container Registry (ACR) for UNIR CP2.
 *
 * Requirements:
 * - SKU: Basic
 * - admin_enabled: true
 * - Mandatory tags include environment = "casopractico2"
 *
 * Note:
 * - ACR is deployed in var.ACR_LOCATION because Azure Policy may restrict regions.
 */

resource "azurerm_container_registry" "ACR" {
  name                = var.ACR_NAME
  resource_group_name = azurerm_resource_group.RG_CP2.name
  location            = var.LOCATION

  sku           = "Basic"
  admin_enabled = true

  tags = var.TAGS
}
