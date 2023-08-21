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

resource "kubernetes_config_map_v1" "cert_manager_cm" {
  metadata {
    name = "cert-manager-config"
    namespace = kubernetes_namespace_v1.cert_manager_namespace.metadata.0.name
  }

  data = {
   values = <<EOF
      installCRDs: true
    EOF
  }
}

resource "kubernetes_config_map_v1" "ingress_nginx_cm" {
  metadata {
    name = "ingress-nginx-config"
    namespace =  kubernetes_namespace_v1.ingress_nginx_namespace.metadata.0.name
  }

  data = {
    values = <<EOF
      controller:
        service:
          annotations:
            service.beta.kubernetes.io/aws-load-balancer-type: nlb
            service.beta.kubernetes.io/do-loadbalancer-enable-proxy-protocol": true
            service.beta.kubernetes.io/do-loadbalancer-tls-passthrough": true
          type: LoadBalancer
    EOF
  }
}

resource "kubernetes_config_map_v1" "external_dns_cm" {
  metadata {
    name = "external-dns-config"
    namespace = var.external_dns_namespace
  }

  data = {
    values = <<EOF
      rbac:
        apiVersion: v1
      serviceAccount:
        annotations:
          eks.amazonaws.com/role-arn: "${module.external_dns_eks_role.iam_role_arn}"
        name: "${var.external_dns_sa_name}"
      txtOwnerId: "${module.eks.cluster_name}"
      logLevel: "debug"
    EOF
  }
}