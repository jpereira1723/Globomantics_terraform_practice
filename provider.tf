# PROVIDERS

provider "azurerm" {
	features {}
	subscription_id = var.subscription_id	
	resource_provider_registrations = "none"
}

provider "azuread" { 

}


