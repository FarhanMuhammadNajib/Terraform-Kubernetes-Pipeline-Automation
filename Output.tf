output "KubeConfig" {
  value = module.oci_oke.KubeConfig
}

output "Cluster" {
  value = module.oci_oke.cluster
}

output "NodePool" {
  value = module.oci_oke.node_pool
}
