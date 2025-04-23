# DATA

data "azurerm_subscription" "current" {}

# RESOURCES

resource "azurerm_resource_group" "sec" { 
	name = var.sec_resource_group_name
	location = var.location

	tags = {
		environment = "security"
	}

}

module "vnet-sec" { 
	source 							= "Azure/vnet/azurerm"
	resource_group_name	= azurerm_resource_group.sec.name
	vnet_location						= var.location
	vnet_name 					= azurerm_resource_group.sec.name
	address_space				= var.sec_vnet_cidr_range
	subnet_prefixes			= var.sec_subnet_prefixes
	subnet_names				= var.sec_subnet_names
	nsg_ids							= {}

	tags = {
		environment = "security" 
		costcenter 	= "security"
	}
}

# AZURE AD SP

resource "random_password" "vnet_peering" {
	length = 16
	special = true
}

resource "azuread_application" "vnet_peering" { 
	display_name = "vnet-peer"
}

resource "azuread_service_principal" "vnet_peering" { 
	application_id = azuread_application.vnet_peering.application_id
}

resource "azuread_service_principal_password" "vnet_peering" { 
	service_principal_id = azuread_service_principal.vnet_peering.id
	end_date_relative		 = "17520h"
}

resource "azurerm_role_definition" "vnet-peering" { 
	name = "allow-vnet-peering" 
	scope = data.azurerm_subscription.current.id
		
	permissions {
		actions = ["Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write", "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/read"]
		not_actions = []
	}

	assignable_scopes = [
		data.azurerm_subscription.current.id
	]
}

resource "azurerm_role_assignment" "vnet" { 
	scope = module.vnet-sec.vnet_id
	role_definition_id = azurerm_role_definition.vnet-peering.role_definition_resource_id
	principal_id = azuread_service_principal.vnet_peering.id
}

# FILE OUTPUT

resource "local_file" "linux" { 
	filename = "${path.module}/next-step.txt"
	content = <<EOF
	export TF_VAR_sec_vnet_id=${module.vnet-sec.vnet_name} 
	export TF_VAR_sec_sub_id=${data.azurerm_subscription.current.subscription_id}
	export TF_VAR_sec_client_id=${azuread_service_principal.vnet_peering.application_id}
	export TF_VAR_sec_principal_id=${azuread_service_principal.vnet_peering.id}
	export TF_VAR_sec_client_secret='${random_password.vnet_peering.result}'
	export TF_VAR_sec_resource_group=${var.sec_resource_group_name}
	export TF_VAR_sec_tenant_id=${data.azurerm_subscription.current.tenant_id}
	EOF
}

