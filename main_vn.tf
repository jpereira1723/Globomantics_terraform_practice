# VARIABLES

variable "resource_group_name" {
	type = string
}

variable "location" {
	type = string
	default = "koreasouth"
}

variable "vnet_cidr_range" {
	type = list(string)
	default = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
	type = list(string)
	default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnet_names" {
	type = list(string)
	default = ["web", "databases"]
}

# PROVIDERS

provider "azurerm" {
	features {}
	subscription_id = "180f7e99-985b-4c30-9eae-9d0552a0d130"	
	resource_provider_registrations = "none"
}

# RESOURCES

