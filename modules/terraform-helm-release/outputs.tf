output "chart_name" {
  value = helm_release.release.chart
}

output "namespace" {
  value = helm_release.release.namespace
}