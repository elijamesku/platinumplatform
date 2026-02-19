terraform {
  required_version = ">= 1.5.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  # Uncomment and configure for remote state
  # backend "s3" {
  #   endpoint   = "https://nyc3.digitaloceanspaces.com"
  #   bucket     = "platinumplatform-terraform-state"
  #   key        = "terraform.tfstate"
  #   region     = "us-east-1"
  #   encrypt    = true
  #   access_key = var.spaces_access_key
  #   secret_key = var.spaces_secret_key
  # }
}

