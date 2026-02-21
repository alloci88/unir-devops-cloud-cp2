/**
 * main.tf
 * -------
 * Terraform configuration for UNIR CP2 (DevOps & Cloud).
 *
 * This file defines:
 * - Terraform CLI version constraint
 * - Required providers and versions
 * - AzureRM provider configuration
 */

terraform {
  /**
   * Terraform CLI version.
   * You are using Terraform 1.14.5, so this constraint is safe.
   */
  required_version = ">= 1.4.0"

  required_providers {
    /**
     * Azure Resource Manager provider.
     * We keep within major version 4 to reduce breaking changes.
     */
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

/**
 * Azure provider configuration.
 * We authenticate via Azure CLI (az login) for this academic project.
 */
provider "azurerm" {
  features {}
}
