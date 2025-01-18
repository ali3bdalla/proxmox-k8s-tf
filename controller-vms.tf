resource "proxmox_vm_qemu" "controler_1" {
  name                        = "rke2-controller-1"
  target_node                 = "pve-1"
  protection                  = true
  vmid                        = 20001
  vm_state                    = "running"
  ciuser                      = "appdepl"
  desc                        = <<-EOT
            <div align='center'><a href='https://Helper-Scripts.com'><img src='https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/images/logo-81x112.png'/></a>
              # Ubuntu 24.04 VM
              <a href='https://ko-fi.com/D1D7EP4GF'><img src='https://img.shields.io/badge/&#x2615;-Buy me a coffee-blue' /></a>
              </div>
        EOT
  qemu_os                     = "l26"
  full_clone                  = true
  cores                       = 2
  vcpus                       = 2
  sockets                     = 1
  memory                      = 4096
  agent                       = 1
  sshkeys                     = var.ssh_keys
  tags                        = "cluster;controller;pve-1"
  clone                       = var.template_name
  os_type                     = "cloud-init"
  scsihw                      = "virtio-scsi-pci"
  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "gw=10.100.70.1,ip=10.100.70.101/24,ip6=dhcp"
  onboot                      = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = 70
  }
}



resource "proxmox_vm_qemu" "controler_2" {
  name                        = "rke2-controller-2"
  target_node                 = "pve-2"
  vmid                        = 20002
  protection                  = true
  vm_state                    = "running"
  ciuser                      = "appdepl"
  desc                        = <<-EOT
            <div align='center'><a href='https://Helper-Scripts.com'><img src='https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/images/logo-81x112.png'/></a>
              # Ubuntu 24.04 VM
              <a href='https://ko-fi.com/D1D7EP4GF'><img src='https://img.shields.io/badge/&#x2615;-Buy me a coffee-blue' /></a>
              </div>
        EOT
  qemu_os                     = "l26"
  full_clone                  = true
  cores                       = 2
  vcpus                       = 2
  sockets                     = 1
  memory                      = 4096
  agent                       = 1
  sshkeys                     = var.ssh_keys
  tags                        = "cluster;controller;pve-2"
  clone                       = var.template_name
  os_type                     = "cloud-init"
  scsihw                      = "virtio-scsi-pci"
  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "gw=10.100.70.1,ip=10.100.70.102/24,ip6=dhcp"
  onboot                      = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = 70
  }
}




resource "proxmox_vm_qemu" "controler_3" {
  name                        = "rke2-controller-3"
  target_node                 = "pve-3"
  vmid                        = 20003
  vm_state                    = "running"
  ciuser                      = "appdepl"
  desc                        = <<-EOT
            <div align='center'><a href='https://Helper-Scripts.com'><img src='https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/images/logo-81x112.png'/></a>
              # Ubuntu 24.04 VM
              <a href='https://ko-fi.com/D1D7EP4GF'><img src='https://img.shields.io/badge/&#x2615;-Buy me a coffee-blue' /></a>
              </div>
        EOT
  qemu_os                     = "l26"
  full_clone                  = true
  cores                       = 2
  vcpus                       = 2
  sockets                     = 1
  memory                      = 4096
  agent                       = 1
  sshkeys                     = var.ssh_keys
  tags                        = "cluster;controller;pve-3"
  clone                       = var.template_name
  os_type                     = "cloud-init"
  scsihw                      = "virtio-scsi-pci"
  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "gw=10.100.70.1,ip=10.100.70.103/24,ip6=dhcp"
  onboot                      = true
  protection                  = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = 70
  }
}


output "controllers_ipconfig" {
  value = {
    "${proxmox_vm_qemu.controler_1.name}" = proxmox_vm_qemu.controler_1.ipconfig0
    "${proxmox_vm_qemu.controler_2.name}" = proxmox_vm_qemu.controler_2.ipconfig0
    "${proxmox_vm_qemu.controler_3.name}" = proxmox_vm_qemu.controler_3.ipconfig0
  }
}
