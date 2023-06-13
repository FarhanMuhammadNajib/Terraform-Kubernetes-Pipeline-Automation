## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "cluster" {
  value = {
    id                 = oci_containerengine_cluster.oci_oke_cluster.id
    kubernetes_version = oci_containerengine_cluster.oci_oke_cluster.kubernetes_version
    name               = oci_containerengine_cluster.oci_oke_cluster.name
  }
}

output "node_pool" {
  value = {
    id                 = oci_containerengine_node_pool.oci_oke_node_pool.id
    kubernetes_version = oci_containerengine_node_pool.oci_oke_node_pool.kubernetes_version
    name               = oci_containerengine_node_pool.oci_oke_node_pool.name
  }
}

output "chosen_node_shape_and_image" {
  value = {
    image_id    = element([for source in data.oci_containerengine_node_pool_option.oci_oke_node_pool_option.sources : source.image_id if length(regexall("Oracle-Linux-${var.node_linux_version}-20[0-9]*.*", source.source_name)) > 0], 0)
    source_name = element([for source in data.oci_containerengine_node_pool_option.oci_oke_node_pool_option.sources : source.source_name if length(regexall("Oracle-Linux-${var.node_linux_version}-20[0-9]*.*", source.source_name)) > 0], 0)
  }
}

output "KubeConfig" {
  value = data.oci_containerengine_cluster_kube_config.KubeConfig.content
}

output "VCN" {
  value ={
    id = oci_core_vcn.oke_vcn[0].id
    endpoint_subnet_id = oci_core_subnet.oke_api_endpoint_subnet[0].id
    lb_subnet_id       = oci_core_subnet.oke_lb_subnet[0].id
    nodepool_subnet_id = oci_core_subnet.oke_nodepool_subnet[0].id
  }
}