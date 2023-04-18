# variable "username" {
#   type = string
# }
# variable "password" {
#   type      = string
#   sensitive = true
# }
variable "repository_name" {
  type = string
}
variable "namespace" {
  type = string
}
variable "description" {
  type    = string
  default = "Example repository"
}
variable "full_description" {
  type    = string
  default = <<-EOT
  "Full description example repository"
  EOT
}
variable "private" {
  type    = bool
  default = false
}