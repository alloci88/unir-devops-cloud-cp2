/**
 * vm.tf
 * -----
 * Linux VM for CP2.
 *
 * Requirements covered:
 * - Linux VM
 * - SSH key managed by Terraform (tls_private_key)
 * - NIC, Public IP, NSG already created in network.tf
 * - Allows SSH (22) and HTTPS (443) via NSG rules
 *
 * Notes:
 * - We use Ubuntu 22.04 LTS (Jammy) image.
 * - The SSH private key is output as sensitive (required by the assignment).
 */

resource "tls_private_key" "SSH_KEY" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

/**
 * Optional but recommended: store the public key as a local value for readability.
 */
locals {
  VM_SSH_PUBLIC_KEY = tls_private_key.SSH_KEY.public_key_openssh
}

/**
 * Linux VM resource.
 */
resource "azurerm_linux_virtual_machine" "CP2_VM" {
  name                = "${var.PROJECT_NAME}-vm"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.RG_CP2.name
  size                = var.VM_SIZE

  admin_username = var.VM_ADMIN_USERNAME

  /**
   * Attach the NIC created in network.tf
   */
  network_interface_ids = [
    azurerm_network_interface.CP2_VM_NIC.id
  ]

  /**
   * Disable password auth: SSH key only (best practice).
   */
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.VM_ADMIN_USERNAME
    public_key = local.VM_SSH_PUBLIC_KEY
  }

  /**
   * OS Disk
   */
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.VM_OS_DISK_SIZE_GB
  }

  /**
   * Ubuntu 22.04 LTS (Jammy)
   */
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  /**
   * Tags (mandatory)
   */
  tags = var.TAGS
}
