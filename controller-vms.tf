
resource "proxmox_vm_qemu" "controllers" {
  name                        = var.controller_vms[count.index].name
  count                       = length(var.controller_vms)
  target_node                 = var.controller_vms[count.index].target_node
  vmid                        = var.controller_vms[count.index].vmid
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
  cores                       = var.controller_vms[count.index].cores
  vcpus                       = var.controller_vms[count.index].vcpus
  sockets                     = 1
  memory                      = var.controller_vms[count.index].memory
  agent                       = 1
  sshkeys                     = var.ssh_keys
  tags                        = "cluster;controller;${var.controller_vms[count.index].target_node}"
  clone                       = var.template_name
  os_type                     = "cloud-init"
  scsihw                      = "virtio-scsi-pci"
  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "ip=${var.controller_vms[count.index].ip_address}/${var.subnet},gw=${var.gateway},ip6=dhcp"
  onboot                      = true
  # protection                  = true
  boot = "order=scsi0" # has to be the same as the OS disk of the template

  ciupgrade = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = var.network_tag
  }

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "local-lvm"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size = "64G"
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
}


output "controllers_ipconfig" {
  # value = {
  #   "${proxmox_vm_qemu.controler_2.name}" = proxmox_vm_qemu.controler_2.ipconfig0
  #   "${proxmox_vm_qemu.controler_1.name}" = proxmox_vm_qemu.controler_1.ipconfig0
  #   "${proxmox_vm_qemu.controler_3.name}" = proxmox_vm_qemu.controler_3.ipconfig0
  # }

  value = {
    for vm in proxmox_vm_qemu.controllers : vm.name => vm.ipconfig0
  }
}
