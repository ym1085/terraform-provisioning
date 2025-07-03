output "debug_security" {
  description = "security 모듈 변수 확인"
  value = {
    alb_security_group = var.alb_security_group
    ecs_security_group = var.ecs_security_group
    ec2_security_group = var.ec2_security_group

    vpc_id = module.network.vpc_id
  }
  sensitive = true
}

output "debug_iam_module" {
  description = "iam 모듈 변수 확인"
  value = {
    iam_custom_role       = var.iam_custom_role
    iam_custom_policy     = var.iam_custom_policy
    iam_managed_policy    = var.iam_managed_policy
    iam_policy_attachment = var.iam_policy_attachment
  }
  sensitive = true
}

output "debug_network_module" {
  description = "network 모듈 변수 확인"
  value = {
    vpc_cidr             = var.vpc_cidr
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    public_subnets_cidr  = var.public_subnets_cidr
    private_subnets_cidr = var.private_subnets_cidr
    availability_zones   = var.availability_zones
  }
  sensitive = true
}

output "debug_elb_module" {
  description = "load_balancer 모듈 변수 확인"
  value = {
    alb                = var.alb
    alb_listener       = var.alb_listener
    alb_listener_rule  = var.alb_listener_rule
    target_group       = var.target_group
    alb_security_group = var.alb_security_group
    public_subnet_ids  = module.network.public_subnet_ids
  }
  sensitive = true
}

output "debug_ecr_module" {
  description = "ecr 모듈 변수 확인"
  value = {
    ecr_repository = var.ecr_repository
  }
  sensitive = true
}

output "debug_ecs_module" {
  description = "ecs 모듈 변수 확인"
  value = {
    vpc_id               = module.network.vpc_id
    public_subnets_cidr  = var.public_subnets_cidr
    private_subnets_cidr = var.private_subnets_cidr
    public_subnet_ids    = module.network.public_subnet_ids
    private_subnet_ids   = module.network.private_subnet_ids

    ecs_cluster                      = var.ecs_cluster
    ecs_task_definitions             = var.ecs_task_definitions
    ecs_service                      = var.ecs_service
    ecs_appautoscaling_target        = var.ecs_appautoscaling_target
    ecs_appautoscaling_target_policy = var.ecs_appautoscaling_target_policy
    ecs_cpu_scale_out_alert          = var.ecs_cpu_scale_out_alert

    ecs_task_role_arn      = module.iam.iam_role_arns["devops-ecs-task-role"]
    ecs_task_exec_role_arn = module.iam.iam_role_arns["devops-ecs-task-exec-role"]
    ecs_security_group     = var.ecs_security_group

    alb_tg_arn       = module.elb.alb_target_group_arn
    alb_listener_arn = module.elb.alb_listener_arn

    alb_security_group_id  = module.security.alb_security_group_id
    ecs_security_group_arn = module.security.ecs_security_group_arn
  }
  sensitive = true
}

output "debug_ec2" {
  description = "ec2 모듈 변수 확인"
  value = {
    vpc_id            = module.network.vpc_id
    public_subnet_ids = module.network.public_subnet_ids

    ec2_security_group   = var.ec2_security_group
    ec2_instance         = var.ec2_instance
    iam_instance_profile = module.iam.iam_instance_profile

    env  = var.env
    tags = var.tags
  }
  sensitive = true
}

output "debug_storage_module" {
  description = "storage 모듈 변수 확인"
  value = {
    s3_bucket = var.s3_bucket
  }
  sensitive = true
}

output "codedeploy" {
  description = "codedeploy 모듈 변수 확인"
  value = {
    codedeploy_app               = var.codedeploy_app
    codedeploy_deployment_group  = var.codedeploy_deployment_group
    codedeploy_deployment_config = var.codedeploy_deployment_config

    service_role_arn = module.iam.iam_role_arns["devops-codedeploy-service-role"]

    alb_listener_arn = module.elb.alb_listener_arn
  }
  sensitive = true
}

output "acm" {
  description = "acm 모듈 변수 확인"
  value = {
    acm_certificate = var.acm_certificate
  }
  sensitive = true
}
