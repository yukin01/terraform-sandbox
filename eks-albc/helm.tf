provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

# resource "helm_release" "albc" {
#   name  = "aws-load-balancer-controller"
#   chart = "./charts/aws-load-balancer-controller"
#   namespace = "kube-system"

#   set {
#     name  = "aws-load-balancer-controller.clusterName"
#     value = module.eks.cluster_id
#   }

#   set {
#     name  = "aws-load-balancer-controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = module.albc_irsa.this_iam_role_arn
#   }
# }

resource "helm_release" "albc" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.9.2"
  namespace  = "kube-system"

  values = [yamlencode(
    {
      clusterName = module.eks.cluster_id
      serviceAccount = {
        name = "aws-load-balancer-controller"
        annotations = {
          "eks.amazonaws.com/role-arn" = module.albc_irsa.this_iam_role_arn
        }
      }
    }
  )]
}