module "gitops_module" {
  source = "./module"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = module.gitops_namespace.name
  kubeseal_cert = module.gitops.sealed_secrets_cert

  entitlement_key = var.cp_entitlement_key
  cluster_name = var.cluster_name
  cluster_ingress = var.ingress_subdomain
  deployer_namespace = module.gitops_namespace.name
}
