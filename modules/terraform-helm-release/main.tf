resource "helm_release" "release" {
  name       = var.release_name
  repository = var.repository
  chart      = var.chart_name
  version    = var.version
  namespace  = var.namespace
  wait       = var.wait
  create_namespace = var.create_namespace

  set = var.set
}