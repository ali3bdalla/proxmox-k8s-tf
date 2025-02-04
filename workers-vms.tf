resource "proxmox_vm_qemu" "workers" {
  name        = var.worker_vms[count.index].name
  count       = length(var.worker_vms)
  target_node = var.worker_vms[count.index].target_node
  vmid        = var.worker_vms[count.index].vmid
  vm_state    = "running"
  ciuser      = "appdepl"
  qemu_os     = "l26"
  full_clone  = true
  cores       = var.worker_vms[count.index].cores
  vcpus       = var.worker_vms[count.index].vcpus
  sockets     = 1
  memory      = var.worker_vms[count.index].memory
  agent       = 1
  sshkeys     = var.ssh_keys
  tags        = "cluster;worker;${var.worker_vms[count.index].target_node}"
  clone       = var.template_name
  os_type     = "cloud-init"
  scsihw      = "virtio-scsi-pci"

  force_recreate_on_change_of = "cicustom"
  ipconfig0                   = "ip=${var.worker_vms[count.index].ip_address}/${var.subnet},gw=${var.gateway},ip6=dhcp"
  onboot                      = false
  boot                        = "order=scsi0" # has to be the same as the OS disk of the template

  ciupgrade = true
  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    tag       = var.network_tag
  }

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
          size = "128G"
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


output "workers_ipconfig" {
  value = {
    for vm_id, vm in proxmox_vm_qemu.workers : vm.name => vm.ipconfig0
  }
}
