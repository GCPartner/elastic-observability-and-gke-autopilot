# Deploying Elastic Observability on GKE AutoPilot and monitoring an App

[![Website](https://img.shields.io/badge/Website-cloud.google.com/kubernetes&hyphen;engine-blue)](https://cloud.google.com/kubernetes-engine) [![Apache License](https://img.shields.io/github/license/GCPartner/elastic-observability-and-gke-autopilot)](https://github.com/GCPartner/elastic-observability-and-gke-autopilot/blob/main/LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/GCPartner/elastic-observability-and-gke-autopilot/pulls) ![](https://img.shields.io/badge/Stability-Experimental-red.svg)

This [Terraform](http://terraform.io) module will allow you to deploy [Google Cloud's GKE AutoPilot](https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview). This module then deploys a [MicroServices](https://github.com/bshetti/opentelemetry-microservices-demo) application, with a web frontend, middlware, and backend database hosted on this GKE AutoPilot cluster. We then use [External DNS](https://github.com/kubernetes-sigs/external-dns) to create DNS records on the fly for our website, and [Cert Manager](https://cert-manager.io/) to get a valid SSL Certificate as well. Lastly, we deploy Elasic Observability to monitor this production ready application!

To try this yourself, click the button below.

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2FGCPartner%2Felastic-observability-and-gke-autopilot&cloudshell_open_in_editor=tutorial%2Fdeploy.sh&cloudshell_tutorial=tutorial%2FREADME.md)
<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->