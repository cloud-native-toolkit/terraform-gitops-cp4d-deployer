# Starter kit for a Terraform GitOps module

This is a prototype module to determine if we can use the Cloud Pak Deployer to handle CP4D deployments for us, and is based on modifications in this PR https://github.com/IBM/cloud-pak-deployer/pull/264

This is expected to be executed on a ROKS cluster, already configured with ODF Storage.  Not all parameters of the Cloud Pak Deployer's CP4D deployment are exposed through this module yet.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.5.3
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git
- etc

## Example usage

```hcl-terraform
module "dev_tools_argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd.git"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  app_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  ingress_subdomain   = module.dev_cluster.ingress_hostname
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  name                = "argocd"
}
```