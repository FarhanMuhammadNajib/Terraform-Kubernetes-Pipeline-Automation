variable "DOCKERHUB_USERNAME" { #Undone
  type      = string
  sensitive = true
}
variable "DOCKERHUB_PASSWORD" { #Undone
  type      = string
  sensitive = true
}
variable "Git_Token" { #Undone
  type      = string
  sensitive = true
}

# Variable For Repo Name
variable "Git_Repo_Name" {
  type = string
}
variable "Docker_Repo_Name" {
  type = string
}

#variable For Kubernetes and oci
#Auth Data
variable "tenancy_ocid" {
  type = string
}
variable "user_ocid" {
  type = string
}
variable "private_key_path" {
  type      = string
  sensitive = true
}
variable "private_key_content" {
  type      = string
  sensitive = true
}
variable "compartment_ocid" {
  type = string
}
variable "region" {
  type    = string
  default = "us-ashburn-1"
}
variable "fingerprint" {
  type      = string
  sensitive = true
}
#Kubernetes Option
variable "k8s_version" {
  type    = string
  default = "v1.26.2"
}
variable "oke_cluster_name" {
  type = string
}

#For Reserved Public IP

variable "public_ip_lifetime" {
  type = string
  default = "RESERVED"
}