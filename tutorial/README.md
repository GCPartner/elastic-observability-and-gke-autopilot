# Deploying Elastic Observability on GKE AutoPilot and monitoring an App (Tutorial)
## Prerequisits (STEP 1)
You will need to have/create two accounts, and a domain:
* [Google Cloud Account](https://console.cloud.google.com/) - New accounts get a $300 Google Cloud credit
  * You can use the default Google Cloud Project after you create a Google Cloud accoumt.
* [Elastic Cloud Deployment](https://console.cloud.google.com/marketplace/product/elastic-prod/elastic-cloud)
  * This can be created using the Google Cloud Marketplace, or an existing Elastic Cloud Account you already have.
* Domain
  * You will need a valid domain or sub-domain
  * You could use [Google Cloud Domain](https://cloud.google.com/domains/docs/register-domain)
  * If using cloud domains, you may get an error in subsiquent steps when we try and create the Cloud DNS Zone, just ignore this.

## Gather information (STEP 2)
We will not be documenting step by step how to gather this information, please refer to each providers own documentation.

### Google Cloud Account
* GCP Project ID
  * Example: my-gcp-project-id
 
Read more [here](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

### Elastic
### TODO: We should probably put the Elastic Marketplace deployment all the way through getting these values out of the manifest
* Fleet URL: 
  * Example: https://44e3b4a4a716464fa7b32a6bb4c64c4e.fleet.us-central1.gcp.cloud.es.io:443
* Fleet Enrollment Token:
  * Example: OVhYLWNJWUIzVnN1VkFhdDZNZlE6ZVoxd0ZGSnVTMjJEam91Zng4Umw2dw==

### Domain
* Your domain or subdomain url
  * Example: foo.bar.com

## Edit the deploy.sh script (STEP 3)
You will need to use the information gathered in Step 2 and edit `scripts/deploy.sh` (which should be open in the cloud shell editor) and populate the following values at the top of the script:
```bash
# Constant Variables
CLUSTER_NAME="elastic"
DOMAIN="<my_domain_name>"
GCP_PROJECT_ID="<my_google_cloud_project>"
GCP_REGION="us-central1"
ELASTIC_FLEET_URL="<my_elastic_fleet_url>"
ELASTIC_FLEET_ENROLLMENT_TOKEN="<my_elastic_fleet_enrollment_token>"
```
## Run the deployment script (STEP 4)
Run the following command in the cloud shell to begin the deployment
```bash
bash scripts/deploy.sh
```
## Finish the configuration (STEP 5)
The script executed in the previous step will do almost everything for you, it will automatically pause and ask you to do the following step:
* Setting you Name Servers (NS) for you domain or sub-domain
  * This is different for every registrar, you'll need to refer to their documentation
    * These values will be automatically printed to the screen once the script has been run

Once those steps are confirmed you must type exactly "Setup Complete!" and strike enter, and the rest of the deployment will continue. This could take around 45 minutes.

## Setup your dashboard(s) in Elastic (STEP 6)
### TODO: There is a lot to fill out here for creating a dashboard
Now that your Kubernetes cluster has been deployed, it has automatically installed the Elastic agent into the Kubernetes cluster. This agent will use the provided `ELASTIC_FLEET_ENROLLMENT_TOKEN` & `ELASTIC_FLEET_URL` to enroll your cluster into your Elastic Deployment. Now we need to setup a dashboard for this cluster.
* Login to the Elastic App
* TODO

## Clean Up Steps
```bash
terraform destroy --auto-approve
```
This will cleanup everything but:
* The Elastic Dashboard
* Elastic Deployment
* Cloud DNS Zones and Records
* Google Cloud Project

You can clean these up manually in that order. 

It would probably also be a good idea to verify these are cleaned up even if terraform doesn't error, as the GKE Cluster could cost money over time.

To cleanup GCP in the event that the `terraform destroy` errors, I would suggest deleting the entire project. (If you purchased a domain via "Cloud Domains" this may result in losing this domain)

Thank you!
