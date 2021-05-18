locals {

  helm_chart_count = length(var.helm_charts)

  helm_charts_defaults = {    
    version           = null
    namespace         = null
    timeout           = null
    create_namespace  = true
    values            = []
    set               = []
  }

}