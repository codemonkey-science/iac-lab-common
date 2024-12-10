## Overview

[![CI/CD Pipeline (self-hosted)](https://github.com/codemonkey-science/iac-lab-common/actions/workflows/ci.yaml/badge.svg)](https://github.com/codemonkey-science/iac-lab-common/actions/workflows/ci.yaml)

This repository contains the Ansible configuration to apply the `common` role to your lab environment. The `common` role includes tasks such as fixing bash prompts, configuring timezones, hardening SSH, and enabling unattended upgrades.

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- SSH access to the target hosts with the appropriate permissions

## Usage

Follow these steps to clone the repository and run the Ansible playbook:

### Step 1: Clone the Repository

Open a terminal and run the following commands to clone the repository and navigate into its directory:

```sh
git clone https://github.com/yourusername/iac-lab-common.git
cd iac-lab-common
```

**Explanation:**
- `git clone https://github.com/yourusername/iac-lab-common.git`: This command clones the repository from GitHub to your local machine.
- `cd iac-lab-common`: This command changes the current directory to the cloned repository.

### Step 2: Run the Ansible Playbook

Run the following command to execute the Ansible playbook:

```sh
ansible-playbook -i inventory site.yml
```

**Explanation:**
- `ansible-playbook`: This is the command to run an Ansible playbook.
- `-i inventory`: This option specifies the inventory file that contains the list of target hosts.
- `site.yml`: This is the main playbook file that includes the `common` role.

### Running the Ansible Playbook with Extra Variables

To run the Ansible playbook with extra variables, such as specifying the `sudo` password and enabling system updates, use the following command:

```sh
ANSIBLE_BECOME_PASS=<your_sudo_password> ansible-playbook -i inventory site.yml --extra-vars "system_update=true"
```

**Explanation:**
- `ANSIBLE_BECOME_PASS=<your_sudo_password>`: This sets the `sudo` password as an environment variable. Replace `<your_sudo_password>` with your actual `sudo` password.
- `ansible-playbook`: This is the command to run an Ansible playbook.
- `-i inventory`: This option specifies the inventory file that contains the list of target hosts.
- `site.yml`: This is the main playbook file that includes the `common` role.
- `--extra-vars "system_update=true"`: This option passes extra variables to the playbook. In this case, it enables system updates.

### Storing the `sudo` Password

There are several ways to securely store and manage the `sudo` password:

1. **Environment Variable:**
  - You can set the `sudo` password as an environment variable in your shell session. This method is shown in the command above.
  - Example:
    ```sh
    export ANSIBLE_BECOME_PASS=<your_sudo_password>
    ansible-playbook -i inventory site.yml --extra-vars "system_update=true"
    ```

2. **Ansible Vault:**
  - Ansible Vault allows you to encrypt sensitive data, such as passwords, within Ansible files.
  - Create an encrypted file to store the `sudo` password:
    ```sh
    ansible-vault create vault.yml
    ```
  - Add the following content to `vault.yml`:
    ```yaml
    ansible_become_pass: <your_sudo_password>
    ```
  - Run the playbook with the vault file:
    ```sh
    ansible-playbook -i inventory site.yml --extra-vars "@vault.yml" --ask-vault-pass
    ```

3. **Prompting for Password:**
  - You can configure Ansible to prompt for the `sudo` password at runtime.
  - Use the `--ask-become-pass` option:
    ```sh
    ansible-playbook -i inventory site.yml --extra-vars "system_update=true" --ask-become-pass
    ```

Choose the method that best fits your security requirements and workflow.

### Example Usage

Here is an example of running the playbook with the `sudo` password set as an environment variable and enabling system updates:

```sh
export ANSIBLE_BECOME_PASS=my_secure_password
ansible-playbook -i inventory site.yml --extra-vars "system_update=true"
```

This command will execute the playbook, applying the `common` role to the target hosts, and enable system updates.

Infrastructure as Code (IaC) repository to apply the `common` Ansible role to the lab.

### Nuances for Different Operating Systems

#### Linux

- Ensure you have the necessary permissions to run Ansible and SSH into the target hosts.
- You may need to install Ansible using your package manager (e.g., `apt`, `yum`, `dnf`).

#### macOS

- You can install Ansible using [Homebrew](https://brew.sh/):
  ```sh
  brew install ansible
  ```
- Ensure your SSH keys are properly configured and accessible.

#### Windows

- Install the Windows Subsystem for Linux (WSL) and set up a Linux distribution (e.g., Ubuntu).
- Install Ansible within the WSL environment.
- Ensure your SSH keys are properly configured and accessible within WSL.

## Additional Information

### Inventory File

The inventory file (`ansible/inventory/hosts`) contains the list of target hosts. Ensure this file is updated with the correct hostnames or IP addresses of your lab environment.

### Ansible Configuration

The Ansible configuration file (`ansible/ansible.cfg`) is pre-configured to use the inventory file and set necessary defaults. You can modify this file if needed to suit your environment.

### Role: Common

The `common` role includes the following tasks:
- Fixing bash prompts
- Copying update scripts
- Configuring timezone
- Hardening SSH
- Enabling unattended upgrades

These tasks are defined in the `ansible/roles/common/tasks/main.yaml` file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.