#Required Provider
terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
    dockerhub = {
      source  = "magenta-aps/dockerhub"
      version = "0.0.14"
    }
  }
}

#Provider setting
provider "github" {
  token = var.Git_Token
  alias = "git"
}
provider "dockerhub" {
  username = var.DOCKERHUB_USERNAME
  password = var.DOCKERHUB_PASSWORD
}
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

#All Resource

#Making DockerHub Repo
module "dockerhub_repository" {
  source = "./Module/Docker"

  repository_name = var.Docker_Repo_Name
  namespace       = var.DOCKERHUB_USERNAME
  private         = false
}

# Making Kubernetes on OCI using OKE
module "oci_oke" {
  #  source                        = "github.com/oracle-quickstart/oci-oke"
  source                        = "./Module/OKE"
  tenancy_ocid                  = var.tenancy_ocid
  compartment_ocid              = var.compartment_ocid
  oke_cluster_name              = var.oke_cluster_name
  use_existing_vcn              = false
  is_api_endpoint_subnet_public = true # OKE API Endpoint will be public (Internet facing)
  is_lb_subnet_public           = true # OKE LoadBalanacer will be public (Internet facing)
  is_nodepool_subnet_public     = false
  k8s_version                   = var.k8s_version
  node_count                    = 1
}

#Making Github Repo including Github Action Workflows
module "Github_Setup-WithActionAlso" {
  source = "./Module/Github"
  providers = {
    github = github.git
  }

  #Repo Basic Data

  repository_name = var.Git_Repo_Name
  #Add branches beside "Main"
  branches = [
    { name = "Dev" }
  ]

  #Upload Needed File

  #Upload Github action file
  GithubAction_file                     = "Build_Pipeline.yml"
  commit_message_GithubAction_Objective = "Building CI/CD pipeline"
  #Upload Docker file
  Dockerfile = "Dockerfile"
  #Upload Kubernetes Yaml for Deployment config
  KubeDeployment_file = "Test.yaml"

  #Environment Setup

  Environment_Name = ["Dev", "Prod"]

  #GithubAction Variable and secret setup

  #Docker Setup
  value_variable_name_docker = var.Docker_Repo_Name
  #Docker Cardential for GitHub Action YAML
  DOCKERHUB_USERNAME = var.DOCKERHUB_USERNAME
  DOCKERHUB_PASSWORD = var.DOCKERHUB_PASSWORD
  #OCI OKE Atribut
  OCI_CLI_USER         = var.user_ocid
  OCI_CLI_TENANCY      = var.tenancy_ocid
  OCI_CLI_FINGERPRINT  = var.fingerprint
  OCI_CLI_KEY_CONTENT  = var.private_key_content
  OCI_CLI_REGION       = var.region
  OCI_CLI_COMPARTEMENT = var.compartment_ocid
  OKE_CLUSTER_OCID     = module.oci_oke.cluster.id
  depends_on = [
    module.dockerhub_repository,
    module.oci_oke
  ]
}