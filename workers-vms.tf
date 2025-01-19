resource "proxmox_vm_qemu" "workers_1" {
  name        = "rke2-worker-1${count.index + 1}"
  count       = 3
  target_node = "pve-1"
  vmid        = 20004 + count.index
  vm_state    = "running"
  ciuser      = "appdepl"
  qemu_os     = "l26"
  full_clone  = true
  cores       = 4
  vcpus       = 4
  sockets     = 1
  memory      = 8192
  agent       = 1
  sshkeys     = var.ssh_keys
  tags        = "cluster;worker;pve-1"
  clone       = var.template_name
  os_type     = "cloud-init"
  scsihw      = "virtio-scsi-pci"

  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "gw=10.100.70.1,ip=10.100.70.${110 + count.index}/24,ip6=dhcp"
  onboot                      = false
  boot                        = "order=scsi0" # has to be the same as the OS disk of the template

  ciupgrade = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = 70
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
          size = "33G"
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

resource "proxmox_vm_qemu" "workers_2" {
  name                        = "rke2-worker-2${count.index + 1}"
  count                       = 3
  target_node                 = "pve-2"
  vmid                        = 20024 + count.index
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
  cores                       = 4
  vcpus                       = 4
  sockets                     = 1
  memory                      = 16384
  agent                       = 1
  sshkeys                     = var.ssh_keys
  tags                        = "cluster;worker;pve-2"
  clone                       = var.template_name
  os_type                     = "cloud-init"
  scsihw                      = "virtio-scsi-pci"
  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "gw=10.100.70.1,ip=10.100.70.${140 + count.index}/24,ip6=dhcp"
  onboot                      = true
  boot                        = "order=scsi0" # has to be the same as the OS disk of the template
  ciupgrade                   = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = 70
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
          size = "34G"
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


resource "proxmox_vm_qemu" "workers_3" {
  name                        = "rke2-worker-3${count.index + 1}"
  count                       = 2
  target_node                 = "pve-3"
  vmid                        = 20044 + count.index
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
  cores                       = 4
  vcpus                       = 4
  sockets                     = 1
  memory                      = 16384
  agent                       = 1
  sshkeys                     = var.ssh_keys
  tags                        = "cluster;worker;pve-3"
  clone                       = var.template_name
  os_type                     = "cloud-init"
  scsihw                      = "virtio-scsi-pci"
  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "gw=10.100.70.1,ip=10.100.70.${160 + count.index}/24,ip6=dhcp"
  onboot                      = true
  boot                        = "order=scsi0" # has to be the same as the OS disk of the template

  ciupgrade = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = 70
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
          size = "33G"
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



output "workers_1_ipconfig" {
  value = {
    for vm_id, vm in proxmox_vm_qemu.workers_1 : vm.name => vm.ipconfig0
  }
}

output "workers_2_ipconfig" {
  value = {
    for vm_id, vm in proxmox_vm_qemu.workers_2 : vm.name => vm.ipconfig0
  }
}


output "workers_3_ipconfig" {
  value = {
    for vm_id, vm in proxmox_vm_qemu.workers_3 : vm.name => vm.ipconfig0
  }
}

