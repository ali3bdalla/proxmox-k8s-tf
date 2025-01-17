# High Availability Kubernetes Cluster on Proxmox Using Terraform

🌐 This repository contains Terraform configurations for provisioning a highly available Kubernetes cluster on Proxmox. It enables the creation of multiple controller plane nodes and a configurable number of worker nodes. To use this setup, ensure you have a predefined VM template available on your Proxmox nodes. 🌐

## Features

🌍 **High Availability:** Deploy multiple Kubernetes controller plane nodes to ensure redundancy and resilience. 🌍
🛠️ **Scalable Workers:** Specify the desired number of worker nodes to suit your workload needs. 🛠️
🌐 **Customizable Configuration:** Define your deployment parameters through a simple variable file. 🌐

## Prerequisites

🔧 Before using this repository, ensure the following: 🔧

- **Proxmox VE:** A working Proxmox Virtual Environment.
- **Predefined Template:** A preconfigured VM template available on the Proxmox nodes. The template should include the necessary base system for Kubernetes installation.
- **Terraform:** Installed on your system (compatible version).

## Setup Instructions

🌐 1. **Clone the Repository:** 🌐

```bash
git clone https://github.com/ali3bdalla/proxmox-k8s-tf
cd proxmox-k8s-tf
```

🛠️ 2. **Define Variables:** 🛠️
Copy the example variables file and update it with your specific configurations:

```bash
cp sample.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` to provide the required details, including Proxmox server details, network configuration, and the number of nodes.

🌐 3. **Initialize Terraform:** 🌐
Run the following command to initialize the Terraform project and download required providers:

```bash
terraform init
```

📊 4. **Plan the Deployment:** 📊
Preview the changes that Terraform will make:

```bash
terraform plan
```

🌐 5. **Apply the Configuration:** 🌐
Deploy the Kubernetes cluster by applying the Terraform plan:

```bash
terraform apply
```

Confirm the execution when prompted.

## Variables Overview

🔧 Refer to `sample.tfvars.example` for all required and optional variables. Key variables include: 🔧

- `pm_api_url`: The Proxmox API endpoint URL, typically in the format `https://<proxmox-host>:8006/api2/json`.
- `pve_nodes`: A list of Proxmox nodes where the VMs will be deployed.
- `pm_enable_debug`: Enable or disable debug mode for the Proxmox API.
- `pm_user`: The username for authenticating with Proxmox (e.g., `root@pam` or `<user>@pve`).
- `pm_password`: The password for the Proxmox user.
- `ssh_keys`: SSH public key(s) to be injected into the VMs.
- `template_name`: The name of the predefined VM template available on the Proxmox nodes.
- `controller_count`: Number of Kubernetes controller plane nodes.
- `worker_count`: Number of Kubernetes worker nodes.
- Networking, storage, and other cluster-specific parameters.

## Sample Variables

Below is an example of the variables you can define in your `terraform.tfvars` file:

```hcl
pm_api_url      = "https://proxmox-host:8006/api2/json"
pve_nodes       = ["pve-1", "pve-2", "pve-3"]
pm_enable_debug = true
pm_user         = "test@pve"
pm_password     = "x"
ssh_keys        = ""
template_name   = "u-2404-tmpl"
```

## Extracting Ansible Inventory

🔧 To generate an `inventory.yaml` file for Ansible: 🔧

1. Install the required Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```
2. Run the provided script to build the inventory:
   ```bash
   python build-inventory.py
   ```

## Cleanup

🌐 To destroy the created resources: 🌐

```bash
terraform destroy
```

## Troubleshooting

🔧 - **Template Not Found:** Ensure the `template_name` in `terraform.tfvars` matches the name of the template on the Proxmox server. 🔧
🌐 - **Network Issues:** Verify the network configuration provided in the variables file. 🌐

## Contributing

🌍 Contributions are welcome! Feel free to open issues or submit pull requests to improve this repository. 🌍

## License

🌐 This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details. 🌐
