# Terraform Provisioning

> 💡 **참고:** 기존 서비스의 구조 및 설정 노출을 방지하기 위해 `terraform.tfvars` 파일은 저장소에 공유하지 않았습니다. 원활한 프로비저닝을 위해 실행 전 각 환경에 맞는 `terraform.tfvars` 파일을 구성해야 합니다.

## Overview

![terraform](./docs/images/terraform.png)

“VPC, ECS, EC2, ALB 등 AWS 인프라를 Terraform 모듈 구조로 설계하고, 환경(dev/stg/prod)별 설정을 분리하여 배포 및 관리합니다.”

## Project Structure

```
├── env/                       # 환경별 설정
│   └── stg/                   # 스테이징 환경
│       └── apne2/             # ap-northeast-2 리전
│           └── devops/        # DevOps 인프라 스택
├── modules/                   # 재사용 가능한 Terraform 모듈
│   └── aws/
│       ├── acm/               # AWS Certificate Manager
│       ├── cicd/              # CI/CD 리소스 (CodeDeploy)
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
- AWS CLI 2.33.29
- Atlantis (optional: for GitOps workflow)

## Deployment

```bash
# 환경 디렉토리로 이동
cd env/stg/apne2/devops

# Terraform 초기화
terraform init

# Terraform 변경 사항 확인
terraform plan

# Terraform 변경 사항 적용
terraform apply
```