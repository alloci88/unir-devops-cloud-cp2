/**
 * role_assignment.tf
 * ------------------
 * Grant AKS permission to pull images from ACR (AcrPull role).
 *
 * Requirements:
 * - AKS identity = SystemAssigned
 * - Role assignment AcrPull towards ACR
 */

resource "azurerm_role_assignment" "AKS_ACR_PULL" {
  scope                = azurerm_container_registry.ACR.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.CP2_AKS.kubelet_identity[0].object_id

  /**
   * Avoid eventual consistency issues: ensure AKS exists before role assignment.
   */
  depends_on = [
    azurerm_kubernetes_cluster.CP2_AKS
  ]
}
