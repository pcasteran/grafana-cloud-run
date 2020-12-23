# grafana-cloud-run

Terraform module allowing to deploy a serverless Grafana instance on Cloud Run.

Inspired by https://github.com/SimoneStefani/grafana-cloudrun.

## TODO

Check reuse network and VPC Access connector.

Use Secret Manager to store the passwords.

Build a custom Docker image for Grafana:
- use the latest version of Grafana
- install the plugins
- retrieve the secrets from Secret Manager

Add info regarding the pricing of Serverless VPC Access : https://cloud.google.com/vpc/docs/configure-serverless-vpc-access#pricing

Module configuration:
1) Specify min provider version (see GCP modules)
2) List of required APIs to be activated (automate it or just list them ? See GCP modules)
   See https://github.com/SimoneStefani/grafana-cloudrun/blob/747bc9962c4682463c4fc22138266c86c1afc693/variables.tf#L17
   gcloud services enable vpcaccess.googleapis.com

Use Google SSO for Grafana : https://geko.cloud/run-grafana-in-docker-with-google-sso/

Add a graph in the doc for the various components (db, cloud run, ...). Use https://diagrams.mingrammer.com/docs/getting-started/examples
