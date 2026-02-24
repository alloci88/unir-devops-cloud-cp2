/**
 * aks.tf
 * ------
 * AKS cluster for UNIR CP2.
 *
 * Requirements:
 * - identity = SystemAssigned
 * - 1 worker node
 * - Tags include environment = "casopractico2"
 * - kubeconfig exported via Terraform output (sensitive)
 */

resource "azurerm_kubernetes_cluster" "CP2_AKS" {
  name                = var.AKS_CLUSTER_NAME
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.RG_CP2.name
  dns_prefix          = var.AKS_DNS_PREFIX

  /**
   * System-assigned managed identity (required).
   */
  identity {
    type = "SystemAssigned"
  }

  /**
   * Default node pool: 1 worker node (required).
   */
  default_node_pool {
    name       = "nodepool1"
    node_count = var.AKS_NODE_COUNT
    vm_size    = var.AKS_NODE_VM_SIZE
  }

  /**
   * Tags (mandatory).
   */
  tags = var.TAGS
}
