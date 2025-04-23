terraform { 
	required_providers { 
		azurerm = {
			source = "hashicorp/azurerm"
			version = "4.26.0"
		}
	
		azuread = {
			source = "hashicorp/azuread"
			version = "~> 1.0"
		}

		local = {
			source = "hashicorp/local"
			version = "~> 2.0"
		}
	}
}
