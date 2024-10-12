terraform {
  required_version = "0.13.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.76.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.4"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "1.3.2"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.2.0"
    }
  }
}
