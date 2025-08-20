# Tofu-AWS Infrastructure Project

This project contains Terraform/OpenTofu configurations for deploying AWS infrastructure as part of a thesis examination at Lernia.

## 🏗️ Project Overview

This infrastructure-as-code project uses OpenTofu (a Terraform fork) to provision and manage AWS resources including:

- **EC2 Instances**: Ubuntu 20.04 LTS servers
- **DynamoDB Tables**: For Terraform state locking
- **S3 Buckets**: For Terraform state storage with versioning

## 📁 Project Structure

```
├── Tofu/                 # Main Terraform configuration
│   ├── provider.tf      # AWS provider and backend configuration
│   ├── ec2.tf          # EC2 instance definitions
│   └── dynamodb.tf     # DynamoDB table for state locking
├── modules/             # Reusable Terraform modules
│   └── s3.tf           # S3 bucket module for state storage
├── .github/            # GitHub workflows and configurations
├── .vscode/            # VS Code workspace settings
└── README.md           # This file
```

## 🚀 Prerequisites

Before using this project, ensure you have:

- **OpenTofu** (version >= 1.9.1) or **Terraform** installed
- **AWS CLI** configured with appropriate credentials
- **AWS Account** with necessary permissions for:
  - EC2 (launch instances, manage security groups)
  - DynamoDB (create tables)
  - S3 (create buckets, manage objects)
  - IAM (if using IAM roles)

## ⚙️ Configuration

### AWS Provider Configuration

The project is configured to use:
- **Region**: `us-east-1`
- **Provider**: OpenTofu AWS provider (version 6.0.0-beta1)

### Backend Configuration

Terraform state is stored remotely in S3:
- **Bucket**: `tf-state-bucket-devops-23`
- **Key**: `test/terraform.tfstate`
- **Region**: `us-east-1`
- **Encryption**: Enabled

State locking is handled by DynamoDB table `tf-locks`.

## 🛠️ Usage

### Initial Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd Tofu-aws
   ```

2. **Navigate to the Terraform directory**:
   ```bash
   cd Tofu
   ```

3. **Initialize OpenTofu**:
   ```bash
   tofu init
   ```

### Deploy Infrastructure

1. **Plan the deployment**:
   ```bash
   tofu plan
   ```

2. **Apply the configuration**:
   ```bash
   tofu apply
   ```

### Destroy Infrastructure

To remove all created resources:
```bash
tofu destroy
```

## 📋 Infrastructure Components

### EC2 Instance
- **AMI**: Ubuntu 20.04 LTS (HVM, SSD)
- **Instance Type**: t2.micro
- **Owner**: Canonical (099720109477)

### DynamoDB Table
- **Name**: tf-locks
- **Billing Mode**: Pay per request
- **Hash Key**: LockID (String)

### S3 Bucket
- **Name**: tf-state-bucket-devops-23
- **Versioning**: Enabled
- **Purpose**: Terraform state storage

## 🔒 Security Considerations

- Terraform state files are encrypted in S3
- State locking prevents concurrent modifications
- Sensitive variables should be stored in `.tfvars` files (not committed to version control)
- Consider using AWS IAM roles with minimal required permissions

## 🧪 Development

### Local Development

For local development, you can override the backend configuration:

```bash
tofu init -backend=false
tofu plan -var-file=local.tfvars
```

### Adding New Resources

1. Create new `.tf` files in the `Tofu/` directory
2. Follow the existing naming conventions
3. Update this README with new resource descriptions
4. Test with `tofu plan` before applying

## 📝 Notes

- This project uses OpenTofu instead of HashiCorp Terraform
- The infrastructure is designed for educational/demonstration purposes
- Production deployments should include additional security configurations
- Consider adding monitoring, logging, and backup strategies for production use
