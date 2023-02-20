#!/usr/bin/env bash


# This script is intended to be run from the root of the git repository (https://github.com/GCPartner/elastic-observability-and-gke-autopilot), like: bash tutorial/deploy.sh 
# Using the "Open in Google Cloud Shell" button is the easiest way to do this.


# Constant Variables
CLUSTER_NAME="elastic" # Must match RFC 952 hostname standard, 10 char maximum or REGEX: ^[a-z0-9]+(-[a-z0-9]+)$
DOMAIN="<my_domain_name>" # This must be a public DNS Zone that you own and can change the NS Records. A subdomin is also fine such as foo.bar.com
GCP_REGION="us-central1"
GCP_PROJECT_ID="<my_google_cloud_project>"
ELASTIC_FLEET_URL="<my_elastic_fleet_url>"
ELASTIC_FLEET_ENROLLMENT_TOKEN="<my_elastic_enrollment_token>"


# COLORS
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
BOLDRED="\e[1;${RED}"
BOLDGREEN="\e[1;${GREEN}"
BOLDBLUE="\e[1;${BLUE}"
ENDCOLOR="\e[0m"


function install_terraform () {
    mkdir -p $HOME/.local/bin
    wget https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
    unzip terraform_1.0.11_linux_amd64.zip
    sudo mv terraform $HOME/.local/bin/
    sudo rm -f terraform_1.0.11_linux_amd64.zip
    echo "PATH=$HOME/.local/bin:\$PATH" >> $HOME/.bashrc
    PATH=$HOME/.local/bin:$PATH
}


function set_project () {
    gcloud config set project $GCP_PROJECT_ID
}


function enable_apis () {
    apis=( 
        "kubernetes.googleapis.com"
        "dns.googleapis.com"
    )
    for api in "${apis[@]}"; do
        gcloud services enable $api --async
    done
}


function create_dns_zone () {
    ZONE_NAME=`echo "$DOMAIN" | tr . -`
    gcloud dns managed-zones create $ZONE_NAME --dns-name="$DOMAIN" --description="DNS Zone for Elastic Observability"
    NS_SERVERS=`gcloud dns managed-zones describe $ZONE_NAME | grep "^-" | awk '{print $2}' |awk '{sub(/.$/,"")}1'`
}


function setup_terraform () {
    cat << EOF > terraform.tfvars
        gcp_project_id     = "$GCP_PROJECT_ID"
        fqdn               = "$CLUSTER_NAME.$DOMAIN"
        cluster_name       = "$CLUSTER_NAME"
EOF
    terraform fmt
    terraform init
}


function wait_for_user_confirmation () {
    cat << EOF


        There is one manual thing you need to do now.

        1) Setup your DNS Zone with the following Name Servers:
        $(echo -e ${BOLDGREEN})
`for ns in $NS_SERVERS; do echo "           $ns"; done`
        $(echo -e ${ENDCOLOR})
        Once this is done...


EOF
    while :; do
        echo -e "Type exactly ${GREEN}'Setup Complete!'${ENDCOLOR} and press {Enter}:"
        read -p "" user_input
        if [ "$user_input" == "Setup Complete!" ]; then
            break
        else
            echo -e "${BOLDRED}Inorrect input, if you would like to cancel, press Ctrl+C${ENDCOLOR}"
        fi
    done
}


function run_terraform () {
    terraform apply --auto-approve
}


# Call functions
install_terraform
set_project
enable_apis
create_dns_zone
setup_terraform
wait_for_user_confirmation
run_terraform
