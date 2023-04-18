terraform {
  required_providers {
    dockerhub = {
      source  = "magenta-aps/dockerhub"
      version = "0.0.14"
    }
  }
}
resource "dockerhub_repository" "repository" {
  name             = var.repository_name
  namespace        = var.namespace
  description      = var.description
  full_description = var.full_description
  private          = var.private
}