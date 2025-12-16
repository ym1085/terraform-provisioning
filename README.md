# Terraform Provisioning

A hands-on AWS infrastructure practice repo using Terraform modules for multiple environments.

## Overview

Deploy and manage AWS infrastructure (VPC, ECS, EC2, ALB, etc.) with modular, environment-specific Terraform configurations.

## Project Structure

```
├── env/                       # Environment-specific configurations
│   └── stg/                   # Staging environment
│       └── apne2/             # ap-northeast-2 region
│           └── devops/        # DevOps infrastructure stack
├── modules/                   # Reusable Terraform modules
│   └── aws/
│       ├── acm/               # AWS Certificate Manager
│       ├── cicd/              # CI/CD resources (CodeDeploy)
│       ├── compute/           # Compute resources (EC2, ECS, EKS)
│       ├── ecr/               # Elastic Container Registry
│       ├── elb/               # Elastic Load Balancer
│       ├── iam/               # IAM roles and policies
│       ├── network/           # VPC and networking
│       ├── security/          # Security groups
│       ├── storage/           # S3 storage
│       └── vpc_endpoint/      # VPC endpoints
└── atlantis.yaml              # Atlantis configuration for GitOps
```

## Prerequisites

- Terraform v1.11.4
- AWS CLI 2.13.8
- Atlantis (optional: for GitOps workflow)

## Environments

> The project supports multiple environments

- `dev`: Development environment
- `stg`: Staging environment
- `prod`: Production environment

## Deployment

> Deploy infrastructure using Terraform cli

```bash
# Move to environment directory
cd env/stg/apne2/devops

# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply
```