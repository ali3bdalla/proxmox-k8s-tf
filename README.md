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
git clone <repository_url>
cd <repository_name>
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

- `proxmox_host`: The Proxmox server address.
- `template_name`: The name of the predefined template.
- `controller_count`: Number of Kubernetes controller plane nodes.
- `worker_count`: Number of Kubernetes worker nodes.
- Networking, storage, and other cluster-specific parameters.

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
