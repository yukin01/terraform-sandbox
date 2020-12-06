locals {
  cluster_name = "my-cluster"

  subnet_tags_for_eks = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}
