# Terraform-Kubernetes Pipeline Automation

This repository contains HCL Terraform files to create the entire architecture needed for pipeline creation, such as GitHub with its actions, Dockerhub, and also Kubernetes server with Oracle Cloud Infrastructure. So in simple terms, the purpose of this repository is to automate the creation of pipeline architecture with the help of infrastructure as a code.

## Requirements

To run these Terraform files, you need the following things:

- GitHub Token form Github account 
- Dockerhub accounts
- Oracle Cloud Infrastructure (OCI) account, tenancy_ocid, user_ocid, fingerprint, private_key_path, and region 

## How to Use

1. Clone this repository to your computer with the command `git clone https://github.com/FarhanMuhammadNajib/Terraform-Kubernetes-Pipeline-Automation.git`
2. Enter the repository directory with the command `cd Terraform-Kubernetes-Pipeline-Automation`
3. Rename the file `terraform.tfvars.example` to `terraform.tfvars` and fill in the variables needed according to your GitHub, Dockerhub, and OCI accounts. You can see the description of the variables in the file `variables.tf`. For the variables that do not have a default value, you need to create environment variables with the prefix `TF_VAR_` and the same name as the variable. For example, in Windows PowerShell, you can use the command:
```powershell
Set-Item -Path env:TF_VAR_DOCKERHUB_USERNAME -Value "UrValue"
```
Terraform will automatically read the environment variables and use their values for the corresponding variables. For more information, you can refer to the [Environment Variables | Terraform | HashiCorp Developer page](https://www.terraform.io/cli/config/environment-variables).

4. Run the command `terraform init` to initialize Terraform and download the required plugins
5. Run the command `terraform plan` to see the plan for creating the pipeline architecture that will be done by Terraform
6. Run the command `terraform apply` to apply the plan and create the pipeline architecture automatically. You will be asked to type `yes` to confirm
7. Wait until the process is complete and pay attention to the output given by Terraform. The output contains important information such as the IP address of the Kubernetes server,and many others.
8. To delete the pipeline architecture that has been created, run the command `terraform destroy` and type `yes` to confirm

## Explanation

This repository consists of several Terraform files that are responsible for creating the pipeline architecture automatically. Here is a brief explanation of each file:

- `main.tf`: The main file that contains the configuration of the OCI, Kubernetes, GitHub, and Dockerhub providers, as well as the invocation of other modules
- `variables.tf`: The file that contains the declaration of the variables used in other Terraform files
- `outputs.tf`: The file that contains the declaration of the output that will be displayed by Terraform after the process is complete
- `module/OKE`: The directory that contains the Terraform files to create OCI resources and Kubernetes resources, such as VCN, subnet, instance, security list, cluster, node pool, service account, and others
- `module/Github`: The directory that contains the Terraform files to create GitHub resources, such as repository, workflow, and secret
- `module/Docker`: The directory that contains the Terraform files to create Dockerhub resources, such as repository
