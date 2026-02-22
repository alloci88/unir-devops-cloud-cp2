/**
 * network.tf
 * ----------
 * Networking for the CP2 VM:
 * - Virtual Network
 * - Subnet
 * - Network Security Group (NSG) with inbound rules:
 *     - SSH (22/tcp)
 *     - HTTPS (443/tcp)
 * - Public IP
 * - Network Interface (NIC)
 * - Association NIC <-> NSG (required by the assignment)
 */

resource "azurerm_virtual_network" "CP2_VNET" {
  name                = "${var.PROJECT_NAME}-vnet"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.RG_CP2.name

  address_space = var.VNET_ADDRESS_SPACE

  tags = var.TAGS
}

resource "azurerm_subnet" "CP2_SUBNET" {
  name                 = "${var.PROJECT_NAME}-subnet"
  resource_group_name  = azurerm_resource_group.RG_CP2.name
  virtual_network_name = azurerm_virtual_network.CP2_VNET.name

  address_prefixes = var.SUBNET_ADDRESS_PREFIX
}

resource "azurerm_network_security_group" "CP2_NSG" {
  name                = "${var.PROJECT_NAME}-nsg"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.RG_CP2.name

  tags = var.TAGS
}

/**
 * NSG inbound rule: SSH
 */
resource "azurerm_network_security_rule" "CP2_NSG_RULE_SSH" {
  name                        = "${var.PROJECT_NAME}-allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.SSH_SOURCE_CIDR
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.RG_CP2.name
  network_security_group_name = azurerm_network_security_group.CP2_NSG.name
}

/**
 * NSG inbound rule: HTTPS
 */
resource "azurerm_network_security_rule" "CP2_NSG_RULE_HTTPS" {
  name                        = "${var.PROJECT_NAME}-allow-https"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.RG_CP2.name
  network_security_group_name = azurerm_network_security_group.CP2_NSG.name
}

/**
 * Public IP for the VM (required for SSH and HTTPS from Internet).
 * Static is nice for reproducibility.
 */
resource "azurerm_public_ip" "CP2_VM_PUBLIC_IP" {
  name                = "${var.PROJECT_NAME}-vm-pip"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.RG_CP2.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.TAGS
}

/**
 * Network Interface for the VM.
 * It connects:
 * - Subnet
 * - Public IP
 */
resource "azurerm_network_interface" "CP2_VM_NIC" {
  name                = "${var.PROJECT_NAME}-vm-nic"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.RG_CP2.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.CP2_SUBNET.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.CP2_VM_PUBLIC_IP.id
  }

  tags = var.TAGS
}

/**
 * Mandatory association: NIC <-> NSG.
 * The assignment explicitly requires NIC↔NSG association.
 */
resource "azurerm_network_interface_security_group_association" "CP2_VM_NIC_NSG_ASSOC" {
  network_interface_id      = azurerm_network_interface.CP2_VM_NIC.id
  network_security_group_id = azurerm_network_security_group.CP2_NSG.id
}
