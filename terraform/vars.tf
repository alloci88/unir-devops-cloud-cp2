variable "PROJECT_NAME" {
  description = "Project identifier used as a prefix for Azure resource names."
  type        = string
  default     = "unir-cp2"
}

variable "LOCATION" {
  description = "Azure region where resources will be deployed."
  type        = string
  default     = "westeurope"
}

variable "ENVIRONMENT" {
  description = "Environment name for tagging (e.g., dev, test, prod)."
  type        = string
  default     = "dev"
}

variable "TAGS" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    project     = "unir-cp2"
    managed_by  = "terraform"
    environment = "dev"
  }
}
