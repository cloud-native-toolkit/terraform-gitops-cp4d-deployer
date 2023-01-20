
variable "gitops_config" {
  type        = object({
    boostrap = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
    })
    infrastructure = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
    services = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
    applications = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
  })
  description = "Config information regarding the gitops repo structure"
}

variable "git_credentials" {
  type = list(object({
    repo = string
    url = string
    username = string
    token = string
  }))
  description = "The credentials for the gitops repo(s)"
  sensitive   = true
}

variable "namespace" {
  type        = string
  description = "The namespace where the application should be deployed"
  default     = "cloud-pak-deployer"
}

variable "kubeseal_cert" {
  type        = string
  description = "The certificate/public key used to encrypt the sealed secrets"
  default     = ""
}

variable "server_name" {
  type        = string
  description = "The name of the server"
  default     = "default"
}

variable "deployer_storage_class" {
  type        = string
  description = "Storage class to be used by the cloud pak deployer"
  default     = "ocs-storagecluster-cephfs"
}

variable "instance_namespace" {
  type        = string
  description = "The namespace where the cloud pak deployer job will be deployed"
  default     = "cpd-instance"
}

variable "cluster_name" {
  type        = string
  description = "The namespace where the cloud pak deployer will be deployed"
}

variable "cluster_ingress" {
  type        = string
  description = "The ingress subdomain for the cluster"
}

variable "cpd_version" {
  type        = string
  description = "The CP4D version to deploy."
  default     = "4.6.1"
}

variable "entitlement_key" {
  type        = string
  description = "The Cloud Pak entitlement key"
}

variable "sequential_install" {
  type        = bool
  description = "Deploy in sequence.  Default is parallel deployment"
  default     = false
}



variable "install_scheduler" {
  type        = bool
  description = "Install scheduler cartridge"
  default     = false
}

variable "install_analyticsengine" {
  type        = bool
  description = "Install Analytics Engine cartridge"
  default     = false
}

variable "install_bigsql" {
  type        = bool
  description = "Install bigsql cartridge"
  default     = false
}

variable "install_ca" {
  type        = bool
  description = "Install ca cartridge"
  default     = false
}

variable "install_cde" {
  type        = bool
  description = "Install cde cartridge"
  default     = false
}

variable "install_datagate" {
  type        = bool
  description = "Install datagate cartridge"
  default     = false
}

variable "install_datastage-ent-plus" {
  type        = bool
  description = "Install datastage-ent-plus cartridge"
  default     = false
}

variable "install_db2" {
  type        = bool
  description = "Install db2 cartridge"
  default     = false
}

variable "install_db2u" {
  type        = bool
  description = "Install db2u cartridge"
  default     = false
}

variable "install_db2wh" {
  type        = bool
  description = "Install db2wh cartridge"
  default     = false
}

variable "install_dmc" {
  type        = bool
  description = "Install dmc cartridge"
  default     = false
}

variable "install_dods" {
  type        = bool
  description = "Install dods cartridge"
  default     = false
}

variable "install_dp" {
  type        = bool
  description = "Install dp cartridge"
  default     = false
}

variable "install_dv" {
  type        = bool
  description = "Install dv cartridge"
  default     = false
}

variable "install_hadoop" {
  type        = bool
  description = "Install hadoop cartridge"
  default     = false
}

variable "install_mdm" {
  type        = bool
  description = "Install mdm cartridge"
  default     = false
}

variable "install_openpages" {
  type        = bool
  description = "Install openpages cartridge"
  default     = false
}

variable "install_planning-analytics" {
  type        = bool
  description = "Install planning-analytics cartridge"
  default     = false
}

variable "install_rstudio" {
  type        = bool
  description = "Install rstudio cartridge"
  default     = false
}

variable "install_spss" {
  type        = bool
  description = "Install spss cartridge"
  default     = false
}

variable "install_voice-gateway" {
  type        = bool
  description = "Install voice-gateway cartridge"
  default     = false
}

variable "install_watson-assistant" {
  type        = bool
  description = "Install watson-assistant cartridge"
  default     = false
}

variable "install_watson-discovery" {
  type        = bool
  description = "Install watson-discovery cartridge"
  default     = false
}

variable "install_watson-ks" {
  type        = bool
  description = "Install watson-ks cartridge"
  default     = false
}

variable "install_watson-openscale" {
  type        = bool
  description = "Install watson-openscale cartridge"
  default     = false
}

variable "install_watson-speech" {
  type        = bool
  description = "Install watson-speech cartridge"
  default     = false
}

variable "install_wkc" {
  type        = bool
  description = "Install wkc cartridge"
  default     = false
}

variable "install_wml" {
  type        = bool
  description = "Install wml cartridge"
  default     = false
}

variable "install_wml-accelerator" {
  type        = bool
  description = "Install wml-accelerator cartridge"
  default     = false
}

variable "install_wsl" {
  type        = bool
  description = "Install wsl cartridge"
  default     = false
}