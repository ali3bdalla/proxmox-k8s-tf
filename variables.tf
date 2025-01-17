variable "pm_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
}

variable "pm_enable_debug" {
  type    = bool
  default = false
}

variable "pm_user" {
  description = "The username to use to authenticate with the Proxmox API"
  type        = string
}

variable "pm_password" {
  description = "The password to use to authenticate with the Proxmox API"
  type        = string
}


variable "pve_nodes" {
  type    = list(string)
  default = []
}

variable "ssh_keys" {
  type = string
}



variable "template_name" {
  type    = string
  default = "u-2404-tmpl"
}
