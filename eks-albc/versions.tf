terraform {
  required_version = "~> 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.11"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.3"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 2.0"
    }
  }
}
