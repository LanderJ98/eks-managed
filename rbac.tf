resource "kubernetes_cluster_role_v1" "full_access" {
  metadata {
    name = var.cluster_role_name
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "full_access_crb" {
  metadata {
    name = var.crb_name
  }
  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.full_access.metadata.0.name
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "User"
    name      = var.role_name
    api_group = "rbac.authorization.k8s.io"
  }
}