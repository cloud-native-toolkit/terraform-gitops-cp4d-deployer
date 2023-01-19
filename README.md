# Starter kit for a Terraform GitOps CP4D Deployer

This is a beta module that uses the [Cloud Pak Deployer](https://ibm.github.io/cloud-pak-deployer/introduction/) to handle CP4D deployments, and is based on modifications in this PR https://github.com/IBM/cloud-pak-deployer/pull/264

This is expected to be executed on an OpenShift cluster which has already been configured with ODF Storage.

## Software dependencies

The module depends on the following software components:

- OpenShift Data Foundation (ODF) - should already be configured on the cluster.

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
module "cp4d" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp4d-deployer.git"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  app_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  ingress_subdomain   = module.dev_cluster.ingress_hostname
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  name                = "cp4d"
  install_watson-assistant = true
  install_watson-ks   = true
  install_watson-speech = true
}
```

## Installation Flags

The following boolean variables can be used to enable cartridges for installation.  These align with the cartridge toggles in the [Cloud Pak Deployer](https://github.com/IBM/cloud-pak-deployer) installation configmap.

- `install_scheduler`
- `install_analyticsengine`
- `install_bigsql`
- `install_ca`
- `install_cde`
- `install_datagate`
- `install_datastage-ent-plus`
- `install_db2`
- `install_db2u`
- `install_db2wh`
- `install_dmc`
- `install_dods`
- `install_dp`
- `install_dv`
- `install_hadoop`
- `install_mdm`
- `install_openpages`
- `install_planning-analytics`
- `install_rstudio`
- `install_spss`
- `install_voice-gateway`
- `install_watson-assistant`
- `install_watson-discovery`
- `install_watson-ks`
- `install_watson-openscale`
- `install_watson-speech`
- `install_wkc`
- `install_wml`
- `install_wml-accelerator`
- `install_wsl`

## Known limitations

- There is a known permission issue for iterative gitops workflows.  After content within the GitOps repo is updated, the deployer job ends with a permission failure.  This module should be used for fresh installations only, until the permission issue is resolved.
- This module supports ODF storage only.  It does not support Portworx storage.
- Executing `terraform destroy` with this module will cleanup the GitOps namespace, but will not automatically clean up the Cloud Pak for Data instance.