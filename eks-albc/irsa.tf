# https://kubernetes-sigs.github.io/aws-load-balancer-controller/latest/deploy/installation/
data "http" "albc_policy_json" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.1.0/docs/install/iam_policy.json"
}

resource "aws_iam_policy" "albc" {
  name   = "AWSLoadBalancerControllerIAMPolicy"
  policy = data.http.albc_policy_json.body
}

module "albc_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "3.5.0"

  create_role                   = true
  role_name                     = "aws-load-balancer-controller"
  role_policy_arns              = [aws_iam_policy.albc.arn]
  provider_url                  = module.eks.cluster_oidc_issuer_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
}
