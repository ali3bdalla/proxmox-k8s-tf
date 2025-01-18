
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_debug        = var.pm_enable_debug
  pm_log_enable   = var.pm_enable_debug
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true

  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

