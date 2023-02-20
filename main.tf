module "gcp-networking" {
  source         = "./modules/gcp-networking"
  cluster_name   = var.cluster_name
  gcp_router_asn = var.gcp_router_asn
  gcp_project_id = var.gcp_project_id
  gcp_region     = var.gcp_region
}

module "gke-cluster" {
  source              = "./modules/gke-cluster"
  cluster_name        = var.cluster_name
  gcp_project_id      = var.gcp_project_id
  gcp_region          = var.gcp_region
  gke_release_channel = var.gke_release_channel
  gcp_network_name    = module.gcp-networking.gcp_network_name
  gcp_subnet_name     = module.gcp-networking.gcp_subnet_name
}

module "cloud-services" {
  depends_on = [
    module.gke-cluster,
  ]
  source                 = "./modules/cloud-services"
  cluster_name           = var.cluster_name
  domain_name            = var.domain_name
  email_address          = var.email_address
  cert_manager_version   = var.cert_manager_version
  gcp_region             = var.gcp_region
  gcp_project_id         = var.gcp_project_id
  redis_load_balancer_ip = local.redis_load_balancer_ip
}