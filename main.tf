locals {
  name          = "cp4d-deployer"
  yaml_dir      = "${path.cwd}/.tmp/${local.name}/chart/${local.name}"
  service_url   = "http://${local.name}.${var.namespace}"
  values_content = {
    deployer_namespace = var.deployer_namespace
    instance_namespace = var.instance_namespace
    cluster_name = var.cluster_name
    cluster_ingress = var.cluster_ingress

    cpd_version = var.cpd_version
    entitlement_key = var.entitlement_key

    license_accept = true
    license = "Enterprise"

    deployer_storage_class = var.deployer_storage_class

    #cartridges
    scheduler =  var.install_scheduler
    analyticsengine =  var.install_analyticsengine
    bigsql =  var.install_bigsql
    ca =  var.install_ca
    cde =  var.install_cde
    datagate =  var.install_datagate
    datastage_ent_plus =  var.install_datastage-ent-plus
    db2 =  var.install_db2
    db2u =  var.install_db2u
    db2wh =  var.install_db2wh
    dmc =  var.install_dmc
    dods =  var.install_dods
    dp =  var.install_dp
    dv =  var.install_dv
    hadoop =  var.install_hadoop
    mdm =  var.install_mdm
    openpages =  var.install_openpages
    planning_analytics =  var.install_planning-analytics
    rstudio =  var.install_rstudio
    spss =  var.install_spss
    voice_gateway =  var.install_voice-gateway
    watson_assistant =  var.install_watson-assistant
    watson_discovery =  var.install_watson-discovery
    watson_ks =  var.install_watson-ks
    watson_openscale =  var.install_watson-openscale
    watson_speech =  var.install_watson-speech
    wkc =  var.install_wkc
    wml =  var.install_wml
    wml_accelerator =  var.install_wml-accelerator
    wsl =  var.install_wsl


    serviceAccount ={ 
      name = "cloud-pak-deployer-sa"
    }

    service-account = {
      name = "cloud-pak-deployer-sa"
      sccs = [ "privileged" ]
      create = true
      roles = ["cluster-admin"]
    }

    podSecurityContext = {}

    securityContext = {
      privileged = true
    }
  }
  layer = "infrastructure"
  type  = "base"
  application_branch = "main"
  namespace = var.namespace
  layer_config = var.gitops_config[local.layer]
}

resource null_resource create_yaml {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-yaml.sh '${local.name}' '${local.yaml_dir}'"

    environment = {
      VALUES_CONTENT = yamlencode(local.values_content)
    }
  }
}

resource gitops_module module {
  depends_on = [null_resource.create_yaml]

  name = local.name
  namespace = var.namespace
  content_dir = local.yaml_dir
  server_name = var.server_name
  layer = local.layer
  type = local.type
  branch = local.application_branch
  config = yamlencode(var.gitops_config)
  credentials = yamlencode(var.git_credentials)
}
