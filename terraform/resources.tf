/**
 * resources.tf
 * -----------
 * Initial resources for CP2.
 *
 * For now, we only create the Resource Group.
 * Next steps will add: ACR, Network, VM, AKS, and Role Assignments.
 */

resource "azurerm_resource_group" "RG_CP2" {
  /**
   * Resource Group name.
   * All other Azure resources will be created inside this RG.
   */
  name     = "${var.PROJECT_NAME}-rg"
  location = var.LOCATION

  /**
   * Mandatory tags (assignment requirement).
   * environment must be "casopractico2".
   */
  tags = var.TAGS
}
