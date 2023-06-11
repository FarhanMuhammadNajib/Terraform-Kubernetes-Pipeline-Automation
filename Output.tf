output "KubeConfig" {
  value = module.oci_oke.KubeConfig
}

output "Cluster" {
  value = module.oci_oke.cluster
}

output "NodePool" {
  value = module.oci_oke.node_pool
}
output "PublicIp" {
  value = oci_core_public_ip.Reserved_public_ip.ip_address
}