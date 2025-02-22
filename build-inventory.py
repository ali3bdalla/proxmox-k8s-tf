#!/usr/bin/env python
import yaml
import json
import subprocess


def get_terraform_output():
    # Run Terraform output command to get the nodes' IPs
    terraform_output = subprocess.check_output(["terraform", "output", "-json"]).decode("utf-8")
    return json.loads(terraform_output)


def extract_ip(config):
    ip_part = [item.split('=')[1] for item in config.split(',') if item.startswith("ip=")][0]
    ip = ip_part.split('/')[0]  # Remove the CIDR part, leaving only the IP address
    return ip


def generate_inventory():
    output = get_terraform_output()

    # Get IP configurations for workers and controllers
    workers = output["workers_ipconfig"]["value"]
    controllers = output["controllers_ipconfig"]["value"]

    # Define Ansible user for all hosts (you can make this dynamic or specific per host)
    ansible_user = "appdepl"  # Modify as per your configuration

    # Prepare the inventory dictionary
    inventory = {
        "all": {
            "vars": {
                "ansible_python_interpreter": "/usr/bin/python3",
                "ansible_ssh_user": ansible_user,
                "ansible_become": True,
                "ansible_become_user": "root"
            },
            "children": {
                "cluster": {
                    "children": {
                        "controller": {
                            "hosts": {
                                controller: {
                                    "ansible_host": extract_ip(config),
                                    "ansible_user": ansible_user
                                } for controller, config in controllers.items()
                            }
                        },
                        "worker": {
                            "hosts": {
                                worker: {
                                    "ansible_host": extract_ip(config),
                                    "ansible_user": ansible_user
                                } for worker, config in workers.items()
                            }
                        }
                    }
                }
            }
        }
    }

    # Write the inventory to a YAML file
    with open("inventory.yaml", "w") as yaml_file:
        yaml.dump(inventory, yaml_file, default_flow_style=False, indent=4)


# Generate and print the inventory
if __name__ == "__main__":
    generate_inventory()
