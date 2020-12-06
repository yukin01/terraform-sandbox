data "aws_eks_cluster" "my_cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "my_cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.my_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.my_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.my_cluster.token
  load_config_file       = false
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "13.2.1"

  cluster_name    = local.cluster_name
  cluster_version = "1.18"
  vpc_id          = module.vpc.vpc_id
  subnets         = concat(module.vpc.private_subnets, module.vpc.public_subnets)

  write_kubeconfig = false
  enable_irsa      = true

  # 余計なリソースを作らないようにする
  worker_create_security_group  = false
  cluster_create_security_group = false

  node_groups = {
    main = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_type    = "t3.medium"
      subnets          = module.vpc.private_subnets
    }
  }
}

resource "aws_security_group_rule" "my_cluster" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb.id

  security_group_id = data.aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
}
