#variable
variable "compartment_ocid" {
  
}
variable "tenancy_ocid" {
  
}
variable "user_ocid" {
  
}
variable "fingerprint" {
  
}
variable "region" {
  default = "us-ashburn-1"
}
variable "private_key_content" {
  
}

#Provider Config
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key      = var.private_key_content
  region           = var.region
}

#Data source output
data "oci_load_balancer_load_balancers" "OKE_load_balancers" {
    #Required
    compartment_id = var.compartment_ocid
    
}
output "LoadBalanacer" {
  value = data.oci_load_balancer_load_balancers.OKE_load_balancers.load_balancers[0].ip_address_details[0].ip_address
}