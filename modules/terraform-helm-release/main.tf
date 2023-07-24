resource "helm_release" "release" {
  name             = var.release_name
  repository       = var.repository
  chart            = var.chart_name
  version          = var.chart_version
  namespace        = var.namespace
  wait             = var.wait
  create_namespace = var.create_namespace

  dynamic "set" {
    for_each = var.set
    content {
      name  = set.value["name"]
      value = set.value["value"]
    }
  }
}