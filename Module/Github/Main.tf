provider "github" {
  token = var.Git_Token
}

#Make A Repo

module "repository" {
  source  = "mineiros-io/repository/github"
  version = "0.18.0"

  name               = var.repository_name
  visibility         = var.visibility
  branches           = var.branches
  archive_on_destroy = var.archive_on_destroy
  allow_rebase_merge = var.allow_rebase_merge
  allow_squash_merge = var.allow_squash_merge
  has_issues         = var.has_issues
  has_projects       = var.has_projects
  has_wiki           = var.has_wiki
  is_template        = var.is_template
  plaintext_secrets = {
    DOCKERHUB_USERNAME  = var.DOCKERHUB_USERNAME
    DOCKERHUB_PASSWORD  = var.DOCKERHUB_PASSWORD
    OCI_CLI_USER        = var.OCI_CLI_USER
    OCI_CLI_TENANCY     = var.OCI_CLI_TENANCY
    OCI_CLI_FINGERPRINT = var.OCI_CLI_FINGERPRINT
    OCI_CLI_KEY_CONTENT = var.OCI_CLI_KEY_CONTENT
    OCI_CLI_REGION      = var.OCI_CLI_REGION
    OKE_CLUSTER_OCID    = var.OKE_CLUSTER_OCID
  }
}

#UPLOAD FILE

#Dockerfile File

resource "github_repository_file" "Dockerfile" {
  repository          = var.repository_name #Variable For Repo
  branch              = "main"
  file                = var.Dockerfile
  content             = file("./${var.Dockerfile}")
  commit_message      = "Add A Dockerfile"
  overwrite_on_create = true
  depends_on = [
    module.repository
  ]
}

#Kubernetes Deployment File

resource "github_repository_file" "KubeDeployment_YAML" {
  repository          = var.repository_name #Variable For Repo
  branch              = "main"
  file                = var.KubeDeployment_file
  content             = file("./Kubernetes/${var.KubeDeployment_file}")
  commit_message      = "Add A Dockerfile"
  overwrite_on_create = true
  depends_on = [
    module.repository
  ]
}

#Github Action File

resource "github_repository_file" "GitHub_action_YAML" {
  repository          = var.repository_name #Variable For Repo
  branch              = "main"
  file                = ".github/workflows/${var.GithubAction_file}"
  content             = file("./${var.GithubAction_file}")
  commit_message      = "Add A Github Action Workflow For ${var.commit_message_GithubAction_Objective}"
  overwrite_on_create = true
  depends_on = [
    module.repository,
    github_repository_file.Dockerfile,
    github_repository_environment.Environtment,
    # Uncomment For Environtmen secret(DEPRECATED)
    # github_actions_environment_secret.Docker_auth,
    github_actions_environment_variable.Docker_Repo
  ]
}

#Make environment on GitHub

data "github_user" "current" {
  username = ""
}

resource "github_repository_environment" "Environtment" {
  for_each    = toset(var.Environment_Name)
  environment = each.key
  repository  = var.repository_name #Variable For Repo
  reviewers {
    users = [data.github_user.current.id]
  }
  deployment_branch_policy {
    protected_branches     = var.protected_branches == false ? false : true
    custom_branch_policies = var.protected_branches == false ? true : false
  }
  depends_on = [
    module.repository
  ]
}

#Create Variable

resource "github_actions_environment_variable" "Docker_Repo" {
  for_each      = toset(var.Environment_Name)
  repository    = var.repository_name #Variable For Repo
  environment   = each.key
  variable_name = var.variable_name_docker
  value         = var.value_variable_name_docker
  depends_on = [
    module.repository,
    github_repository_environment.Environtment
  ]
}

resource "github_actions_environment_variable" "Docker_Tags" {
  for_each      = toset(var.Environment_Name)
  repository    = var.repository_name #Variable For Repo
  environment   = each.key
  variable_name = var.variable_tags_docker
  value         = each.key
  depends_on = [
    module.repository,
    github_repository_environment.Environtment
  ]
}
# resource "github_actions_environment_variable" "OKE_Attribut" {
#   for_each      = var.EnvVar
#   repository    = var.repository_name #Variable For Repo
#   environment   = each.value.env
#   variable_name = each.key
#   value         = each.value.value
#   depends_on = [
#     module.repository,
#     github_repository_environment.Environtment
#   ]
# }



# #Create Secrets Variable For Environtmen (DEPRECATED)

# resource "github_actions_environment_secret" "Docker_auth" {
#   for_each = Join("\n",[var.Environment_Name, Var.secret_name]) 
#   repository      = var.repository_name #Variable For Repo
#   environment     = each.value["Environment_Name"]
#   secret_name     = each.value["secret_name"]
#   plaintext_value = var.DOCKERHUB_USERNAME
#   depends_on = [
#     module.repository,
#     github_repository_environment.Prod_environtment
#   ]
# }