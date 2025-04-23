# VARIABLES

variable "resource_group_name" {
	type = string
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

variable "subscription_id" {
	default = ""
}

variable "sec_resource_group_name" { 
	type = string
	default = "security"
}

variable "sec_vnet_cidr_range" {
	type = list(string)
	default = ["10.1.0.0/16"]
}

variable "sec_subnet_prefixes" { 
	type = list(string)
	default = ["10.1.0.0/24", "10.1.1.0/24"]
}

variable "sec_subnet_names" {
	type = list(string)
	default = ["siem", "inspect"]
}

variable "location" {
	type = string
	default = "koreasouth"
}
