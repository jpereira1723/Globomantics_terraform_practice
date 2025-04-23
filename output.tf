# OUTPUT

output "vnet_id" { 
	value = module.vnet-sec.vnet_id
}

output "vnet_name" { 
	value = module.vnet-sec.vnet_name
}

output "service_principal_client_id" {
	value = azuread_service_principal.vnet_peering.id
}

output "service_principal_client_secret" { 
	value = random_password.vnet_peering.result
	sensitive = true
}

output "resource_group_name" { 
	value = azurerm_resource_group.sec.name
}
