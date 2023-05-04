#Variable For Provider
# variable "Git_Token" {
#   type      = string
#   sensitive = true
# }

#Variable For Repo

variable "repository_name" {
  description = "Repository name"
  type        = string
}
variable "visibility" {
  type    = string
  default = "public"
}
variable "branches" {
  type    = list(any)
  default = [{ name = null }]
}
variable "archive_on_destroy" {
  type    = bool
  default = false
}
variable "allow_rebase_merge" {
  type    = bool
  default = true
}
variable "allow_squash_merge" {
  type    = bool
  default = true
}
variable "has_issues" {
  type    = bool
  default = false
}
variable "has_projects" {
  type    = bool
  default = false
}
variable "has_wiki" {
  type    = bool
  default = false
}
variable "is_template" {
  type    = bool
  default = false
}

#Variable for repo secret
variable "DOCKERHUB_USERNAME" {
  type      = string
  sensitive = true
}
variable "DOCKERHUB_PASSWORD" {
  type      = string
  sensitive = true
}
variable "OCI_CLI_USER" {
  type      = string
  sensitive = true
}
variable "OCI_CLI_TENANCY" {
  type      = string
  sensitive = true
}
variable "OCI_CLI_FINGERPRINT" {
  type      = string
  sensitive = true
}
variable "OCI_CLI_KEY_CONTENT" {
  type      = string
  sensitive = true
}
variable "OCI_CLI_REGION" {
  type      = string
  sensitive = true
}
variable "OKE_CLUSTER_OCID" {
  type      = string
  sensitive = true
}
variable "OCI_CLI_COMPARTEMENT" {
  type = string
  sensitive = true
}
#Variable For Upload File
variable "Dockerfile" {
  description = "A Name For A Dockerfile"
  type        = string
  default     = "Dockerfile"
}

variable "KubeDeployment_file" {
  description = "A Name For Kubernetes Yaml deployment config file"
  type        = string
}

variable "GithubAction_file" {
  description = "A Name For A Github Action File With YAML Format"
  type        = string
  default     = "GithubAction_file.yaml"
}

variable "commit_message_GithubAction_Objective" {
  type    = string
  default = "Github Action"
}

#Variable For Make Environment

variable "Environment_Name" {
  type    = list(string)
  default = []
}
variable "protected_branches" {
  type    = bool
  default = false
}

#Variable For Environment Variable

variable "variable_name_docker" {
  type    = string
  default = "Docker_Repo"
}

variable "value_variable_name_docker" {
  type = string
}

variable "variable_tags_docker" {
  type    = string
  default = "Docker_Tags"
}

#Env Variable 
# variable "EnvVar" {
#   type    = map(any)
#   default = {
#     #"Variable_name" = {env="",value=""}
#   }
# }

# #Secret Variable For Environment(DEPRECATED)

# variable "secret_name" {
#   type = map(string)
#   default = {
#     "secret_name" = "DOCKERHUB_USERNAME"
#     "secret_name" = "DOCKERHUB_PASSWORD"
#   }
# }