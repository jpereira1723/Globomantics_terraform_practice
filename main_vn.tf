# RESOURCES

module "vnet-main" {
	source 							= "Azure/vnet/azurerm"
	resource_group_name = var.resource_group_name
	vnet_location 			= var.location
	vnet_name						= var.resource_group_name
	address_space				= var.vnet_cidr_range
	subnet_prefixes			= var.subnet_prefixes
	subnet_names				= var.subnet_names
	nsg_ids							= {}
	
	tags = {
		environment = "dev"
		costcenter	= "it"
	}
}

