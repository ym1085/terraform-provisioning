locals {

  # ALB security group ingress rule
  alb_security_group_ingress_rules = {
    devops-alb-sg-ingress-rule = [
      {
        security_group_name = "devops-alb-sg"
        type                = "ingress"
        description         = "devops alb http security group ingress rule"
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_ipv4 = [
          "220.75.180.0/24"
        ]
        security_groups = null
        env             = "stg"
      },
      {
        security_group_name = "devops-alb-sg"
        type                = "ingress"
        description         = "devops alb https security group ingress rule"
        from_port           = 443
        to_port             = 443
        protocol            = "tcp"
        cidr_ipv4 = [
          "220.75.180.0/24"
        ]
        security_groups = null
        env             = "stg"
      }
    ]
  }

  # Flatten alb security group ingress rule
  alb_ingress_rules_flat = flatten([
    for group in values(local.alb_security_group_ingress_rules) : [
      for rule in group : [
        for cidr in rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [] : {
          security_group_name = rule.security_group_name
          type                = rule.type
          description         = rule.description
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = cidr
          security_groups     = rule.security_groups
          env                 = rule.env
        }
      ]
    ]
  ])

  # ALB security group egress rule
  alb_security_group_egress_rules = {
    devops-alb-sg-egress-rule = [
      {
        security_group_name = "devops-alb-sg"
        type                = "egress"
        description         = "devops alb all traffic security group egress rule"
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_ipv4 = [
          "0.0.0.0/0"
        ]
        security_groups = null
        env             = "stg"
      }
    ]
  }

  # Flatten alb security group ingress rule
  alb_egress_rules_flat = flatten([
    for group in values(local.alb_security_group_egress_rules) : [
      for rule in group :
      rule.cidr_ipv4 != null ? [
        for cidr in rule.cidr_ipv4 : {
          security_group_name = rule.security_group_name
          type                = rule.type
          description         = rule.description
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = cidr
          security_groups     = null
          env                 = rule.env
        }
        ] : [
        {
          security_group_name = rule.security_group_name
          type                = rule.type
          description         = rule.description
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = null
          security_groups     = rule.security_groups
          env                 = rule.env
        }
      ]
    ]
  ])

  # ECS security group ingress rule
  ecs_security_group_ingress_rules = {
    devops-ecs-sg-ingress-rule = [
      {
        security_group_name = "devops-ecs-sg"
        type                = "ingress"
        description         = "devops ecs service port"
        from_port           = 8080
        to_port             = 8080
        protocol            = "tcp"
        cidr_ipv4 = [
          "220.75.180.0/24"
        ]
        security_groups = null
        env             = "stg"
      }
    ]
  }

  # Flatten ecs security group ingress rule
  ecs_ingress_rules_flat = flatten([
    for group in values(local.ecs_security_group_ingress_rules) : [
      for rule in group : rule.cidr_ipv4 != null ? [
        for cidr in rule.cidr_ipv4 : {
          security_group_name = rule.security_group_name
          type                = rule.type
          description         = rule.description
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = cidr
          security_groups     = null
          env                 = rule.env
        }
        ] : [
        {
          security_group_name = rule.security_group_name
          type                = rule.type
          description         = rule.description
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = null
          security_groups     = rule.security_groups
          env                 = rule.env
        }
      ]
    ]
  ])

  # ECS security group egress rule
  ecs_security_group_egress_rules = {
    devops-ecs-sg-egress-rule = [
      {
        security_group_name = "devops-ecs-sg"
        type                = "egress"
        description         = "ecs security group egress rule"
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_ipv4 = [
          "0.0.0.0/0"
        ]
        security_groups = null
        env             = "stg"
      }
    ]
  }

  # Flatten ecs security group egress rule
  ecs_egress_rules_flat = flatten([
    for group in values(local.ecs_security_group_egress_rules) : [
      for rule in group : [
        for cidr in rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [] : {
          security_group_name = rule.security_group_name
          type                = rule.type
          description         = rule.description
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = cidr
          security_groups     = rule.security_groups
          env                 = rule.env
        }
      ]
    ]
  ])

  # EC2 security group ingress rule
  ec2_security_group_ingress_rules = {
    devops-bastion-sg-ingress-rule = [
      {
        security_group_name = "devops-bastion-sg" # 참조하는 보안그룹 이름을 넣어야 each.key로 구분 가능
        type                = "ingress"
        description         = "bastion security group inbound"
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_ipv4 = [
          "220.75.180.0/24"
        ]
        security_groups = null
        env             = "stg"
      }
    ]
  }

  # Flatten ec2 security group ingress rule
  ec2_ingress_rules_flat = flatten([
    for group in values(local.ec2_security_group_ingress_rules) : [
      for rule in group : [
        for cidr in rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [] : {
          security_group_name = rule.security_group_name
          type                = rule.type
          description         = rule.description
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = cidr
          security_groups     = rule.security_groups
          env                 = rule.env
        }
      ]
    ]
  ])

  # EC2 security group egress rule
  ec2_security_group_egress_rules = {
    devops-bastion-sg-egress-rule = [
      {
        security_group_name = "devops-bastion-sg"
        description         = "bastion security group egress rule"
        type                = "egress"
        from_port           = 0
        to_port             = 0
        protocol            = "-1" # 모든 프로토콜 허용
        cidr_ipv4 = [
          "0.0.0.0/0"
        ]
        security_groups = null
        env             = "stg"
      }
    ]
  }

  # Flatten ec2 security group egress rule
  ec2_egress_rules_flat = flatten([
    for group in values(local.ec2_security_group_egress_rules) : [
      for rule in group : [
        for cidr in rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [] : {
          security_group_name = rule.security_group_name
          description         = rule.description
          type                = rule.type
          from_port           = rule.from_port
          to_port             = rule.to_port
          protocol            = rule.protocol
          cidr_ipv4           = cidr
          security_groups     = rule.security_groups
          env                 = rule.env
        }
      ]
    ]
  ])
}
