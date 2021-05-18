resource "helm_release" "charts" {
  count             = local.helm_chart_count
  
  name              = lookup(var.helm_charts[count.index], "name", var.helm_charts[count.index].chart)
  repository        = var.helm_charts[count.index].repository
  chart             = var.helm_charts[count.index].chart

  version           = lookup(var.helm_charts[count.index], "version", local.helm_charts_defaults.version)
  namespace         = lookup(var.helm_charts[count.index], "namespace", local.helm_charts_defaults.namespace)
  timeout           = lookup(var.helm_charts[count.index], "timeout", local.helm_charts_defaults.timeout)
  create_namespace  = lookup(var.helm_charts[count.index], "create_namespace", local.helm_charts_defaults.create_namespace)

  values = [
    for value in lookup(var.helm_charts[count.index], "values", local.helm_charts_defaults.values): 
        "${file("${value}")}"
  ]

  dynamic "set" {
    for_each = lookup(var.helm_charts[count.index], "set", local.helm_charts_defaults.set)
    content {
      name  = set.value.name
      value = set.value.value
      type  = lookup(set.value, "type", "auto")
    }
  }
}