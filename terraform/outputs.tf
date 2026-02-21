/**
 * outputs.tf
 * ----------
 * Outputs required for CP2.
 *
 * Only currently available outputs are defined.
 * Future outputs (ACR, VM, AKS) are documented below and will be enabled
 * once their corresponding resources are created.
 */

/**
 * Resource Group name.
 * Used by Ansible and for validation purposes.
 */
output "resource_group_name" {
  description = "Name of the Azure Resource Group."
  value       = azurerm_resource_group.RG_CP2.name
}

/**
 * Deployment location.
 */
output "location" {
  description = "Azure region where resources are deployed."
  value       = var.LOCATION
}

/**
 * Azure Container Registry login server (used to tag/push/pull images).
 * Example: <name>.azurecr.io
 */
output "acr_login_server" {
  description = "ACR login server (e.g., <name>.azurecr.io)."
  value       = azurerm_container_registry.ACR.login_server
}

/**
 * ACR admin username (admin_enabled=true).
 */
output "acr_admin_username" {
  description = "ACR admin username."
  value       = azurerm_container_registry.ACR.admin_username
}

/**
 * ACR admin password (admin_enabled=true).
 * Marked as sensitive to avoid accidental display.
 */
output "acr_admin_password" {
  description = "ACR admin password."
  value       = azurerm_container_registry.ACR.admin_password
  sensitive   = true
}

/* ---------------------------------------------------------------------------
   FUTURE REQUIRED OUTPUTS (to be enabled when resources exist)

output "vm_public_ip" {
  value = azurerm_public_ip.VM_PUBLIC_IP.ip_address
}

output "ssh_private_key_pem" {
  value     = tls_private_key.SSH_KEY.private_key_pem
  sensitive = true
}

output "kube_config_raw" {
  value     = azurerm_kubernetes_cluster.AKS.kube_config_raw
  sensitive = true
}
--------------------------------------------------------------------------- */
