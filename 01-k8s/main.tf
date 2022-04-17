provider "kubernetes" {
  config_context_cluster   = "minikube"
}

resource "kubernetes_namespace" "minikube-namespace" {
  metadata {
    name = "tel4vn-namespace"
  }
}

//provider "helm" {
//  kubernetes {
//        config_context_cluster   = "minikube"       
//  }
//}

//resource "helm_release" "local" {
//  name          = "tel4vnchart"
//  chart         = "./tel4vnchart"
//}

