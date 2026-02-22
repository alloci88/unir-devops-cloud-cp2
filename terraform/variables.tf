/**
 * variables.tf
 * ------------
 * Input vars for the CP2 infrastructure.
 *
 * Notes:
 * - We use UPPERCASE variable names by convention in this repository.
 * - Tags are centralized to ensure every resource includes:
 *   environment = "casopractico2"
 */

/**
 * Azure Container Registry name.
 *
 * Rules:
 * - Must be globally unique across Azure.
 * - Only alphanumeric characters (no hyphens).
 * - 5-50 characters.
 */
variable "ACR_NAME" {
  description = "Globally unique Azure Container Registry name (alphanumeric only)."
  type        = string
  default     = "unircp2acr88"
}

variable "PROJECT_NAME" {
  description = "Project identifier used as a prefix for Azure resource names."
  type        = string
  default     = "unir-cp2"
}

variable "LOCATION" {
  description = "Azure region where resources will be deployed."
  type        = string
  default     = "germanywestcentral"
}

/**
 * Environment tag required by the assignment rules.
 * Keep this value as 'casopractico2' to comply with the rubric.
 */
variable "ENVIRONMENT" {
  description = "Environment name for tagging."
  type        = string
  default     = "casopractico2"
}

/**
 * Common tags applied to all Azure resources created by Terraform.
 * IMPORTANT: Must include environment = "casopractico2".
 */
variable "TAGS" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    project     = "unir-cp2"
    managed_by  = "terraform"
    environment = "casopractico2"
  }
}

/**
 * Networking
 * ----------
 * Address space and subnet for the VM.
 */

variable "VNET_ADDRESS_SPACE" {
  description = "VNet address space for the CP2 environment."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "SUBNET_ADDRESS_PREFIX" {
  description = "Subnet address prefix where the VM NIC will be placed."
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

/**
 * Security
 * --------
 * Source allowed for SSH. Use a CIDR like 'X.X.X.X/32'.
 * Default is open for academic simplicity.
 */
variable "SSH_SOURCE_CIDR" {
  description = "CIDR allowed to SSH into the VM (22/tcp)."
  type        = string
  default     = "0.0.0.0/0"
}
