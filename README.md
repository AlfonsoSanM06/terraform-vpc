# Terraform AWS Secure SSH VPC

## 1. Overview
This project demonstrates how to provision secure infrastructure on AWS using Terraform, focusing on networking fundamentals and access hardening.
The main objective is to deploy EC2 instances (in this case, 3) inside a custom VPC, dynamically restricting SSH access to the user's current public IP.

This project is designed as technical practice and for a portfolio.

## 2. Architecture
The infrastructure created by this project includes:
* A custom VPC (CIDR: 10.0.0.0/16)
* Two public subnets distributed across different Availability Zones (AZs)
* Internet Gateway for internet access
* Security Group with:
    * SSH access restricted to the user's public IP (/32)
    * HTTPS access enabled
* EC2 Instance deployed inside the VPC

## 3. Technologies Used
For this project, I used Terraform for deployment, utilizing AWS EC2, AWS VPC, and AWS Security Groups.

## 4. Prerequisites
Before deploying the project, ensure you have:
* An active AWS account, a generated IAM user with permissions, and access keys.
* AWS CLI installed and configured. You can install it [here using this guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
* Once installed, run `aws configure` and enter the keys.
* Terraform must also be installed.
* Basic knowledge of Linux, networking, and AWS.

## 5. Project Structure

* `main.tf` → Main infrastructure definition
* `networking.tf` → VPC, subnets, and security groups
* `providers.tf` → Terraform and AWS configuration
* `variables.tf` → Input variables
* `outputs.tf` → Outputs (user public IP, server IPs)
* `locals.tf` → Local values (Dynamic user public IP)
* `.gitignore` → Files ignored by Git
* `README.md`

Each file has a single responsibility, following best practices.

## 6. Configuration
### Dynamic IP Restriction for SSH
The user's public IP is automatically obtained via an external HTTP data source:
1. The IP is queried from https://api.ipify.org
2. It is converted into a /32 CIDR block
3. Finally, it is injected directly into the Security Group rules

This guarantees that SSH access is always limited to the current location, without manual changes.

## 7. How to use it

Clone the repository:
```bash
git clone <url-del-repositorio>
cd terraform-aws-secure-ssh
Initialize Terraform:

Bash

terraform init
Once all files are ready, run plan to check everything is in order:

Bash

terraform plan
Apply the infrastructure for creation. It will show a list of resources or errors:

Bash

terraform apply
Confirm with yes when prompted.

After deployment → verify that the VPC and subnets exist, and check that the security group only allows SSH from your IP. To connect:

Bash

ssh -i your-key.pem ubuntu@<public-ip>
If your IP changes, simply run again:

Bash

terraform apply
and it will update automatically.

In case you want to remove the infrastructure, run:

Bash

terraform destroy
8. Security Considerations
SSH limited to a single IP (/32)

No credentials stored in the repository

Principle of least privilege in network rules

Reproducible and auditable infrastructure

Author Alfonso ASIR Student | DevOps Junior
