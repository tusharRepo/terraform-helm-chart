resource "helm_release" "charts" {
  count             = local.helm_chart_count
  
  name              = var.helm_charts[count.index].name
  repository        = var.helm_charts[count.index].repository
  chart             = var.helm_charts[count.index].chart

  version           = lookup(var.helm_charts[count.index], "version", local.helm_charts_defaults.version)
  namespace         = lookup(var.helm_charts[count.index], "namespace", local.helm_charts_defaults.namespace)
  timeout           = lookup(var.helm_charts[count.index], "timeout", local.helm_charts_defaults.timeout)
  create_namespace  = lookup(var.helm_charts[count.index], "create_namespace", local.helm_charts_defaults.create_namespace)

  values = [
    for value in var.helm_charts[count.index].values: 
        "${file("${value}")}"
  ]
}