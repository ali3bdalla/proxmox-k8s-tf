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


variable "controller_vms" {

  type = list(object({
    target_node = string
    vmid        = number
    ip_address  = string
    name        = string
    memory      = number
    cores       = number
    vcpus       = number
  }))
  default = []
}
variable "worker_vms" {

  type = list(object({
    target_node = string
    vmid        = number
    ip_address  = string
    name        = string
    memory      = number
    cores       = number
    vcpus       = number
  }))
  default = []
}
variable "ssh_keys" {
  type = string
}



variable "template_name" {
  type    = string
  default = "u-2404-tmpl"
}


variable "gateway" {
  type = string
}

variable "subnet" {
  type    = number
  default = 24
}

variable "network_tag" {
  type    = number
  default = 70
}
