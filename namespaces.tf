resource "kubernetes_namespace_v1" "cert_manager_namespace" {
  metadata {
    name = var.cert_manager_namespace
  }
}

resource "kubernetes_namespace_v1" "ingress_nginx_namespace" {
  metadata {
    name = var.nginx_namespace
  }
}

resource "kubernetes_namespace_v1" "apps_namespace" {
  metadata {
    name = var.apps_namespace
  }
}