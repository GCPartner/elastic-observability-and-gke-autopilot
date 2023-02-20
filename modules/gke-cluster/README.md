<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the GKE cluster | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID to deploy the cluter into | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The region to deploy the cluster in | `string` | n/a | yes |
| <a name="input_gke_release_channel"></a> [gke\_release\_channel](#input\_gke\_release\_channel) | The gke release channel to deploy | `string` | n/a | yes |
| <a name="input_gcp_network_name"></a> [gcp\_network\_name](#input\_gcp\_network\_name) | The name of the GCP Network | `string` | n/a | yes |
| <a name="input_gcp_subnet_name"></a> [gcp\_subnet\_name](#input\_gcp\_subnet\_name) | The name of the GCP Network | `string` | n/a | yes |
<!-- END_TF_DOCS -->