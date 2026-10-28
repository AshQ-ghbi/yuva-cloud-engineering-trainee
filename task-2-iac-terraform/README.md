# Cloud Automation and Infrastructure as Code (IaC) Implementation

## Overview
This module contains the HashiCorp Terraform configuration files used to automate the deployment of a scalable, highly available, multi-tier cloud environment on Amazon Web Services (AWS). By utilizing Infrastructure as Code (IaC), this project eliminates manual console configurations, ensures version control, and establishes a repeatable deployment methodology.

## Contents
* **`variables.tf`**: Parameter definitions including VPC CIDR blocks, subnet ranges, and target AWS region.
* **`main.tf`**: Foundational networking resources including the custom VPC, Public/Private Subnets, Internet Gateway, and NAT Gateway.
* **`compute.tf`**: Web and application tier resources, including the Application Load Balancer (ALB), Auto Scaling Group (ASG), Launch Templates, and Security Groups.
* **`database.tf`**: Data tier resources provisioning a secure Amazon RDS PostgreSQL instance in isolated private subnets.
* **`outputs.tf`**: Extracts and displays post-deployment connection details (ALB public DNS name and Database endpoint).

## Architecture Implemented
The Terraform scripts provision the following multi-tier topology:
1. **Networking Tier:** A custom VPC spanning two Availability Zones to ensure high availability.
2. **Security Tier:** Strictly mapped Security Groups enforcing the principle of least privilege (e.g., the database only accepts traffic from the application tier).
3. **Compute Tier:** An Auto Scaling Group (2 to 6 instances) fronted by an Application Load Balancer for dynamic traffic distribution.
4. **Data Tier:** A managed Amazon RDS relational database shielded from direct public internet access.

## Deployment Instructions

### Prerequisites
* [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.5.0 or later) installed locally.
* [AWS CLI](https://aws.amazon.com/cli/) installed and configured with valid IAM programmatic access credentials.

### Execution Steps

1. **Initialize the working directory:** (Downloads the AWS provider plugins)

    ```bash
    terraform init
    ```

2. **Validate the configuration:** (Ensures syntax is correct)

    ```bash
    terraform validate
    ```

3. **Generate an execution plan:** (Dry-run to see what will be built)

    ```bash
    terraform plan -var="db_password=YourSecurePassword123!"
    ```

4. **Apply and provision resources:** (Builds the infrastructure on AWS)

    ```bash
    terraform apply -var="db_password=YourSecurePassword123!" -auto-approve
    ```

5. **Clean up resources:** (Destroys the sandbox environment to prevent idle billing)

    ```bash
    terraform destroy -var="db_password=YourSecurePassword123!" -auto-approve
    ```
