#!/usr/bin/env zsh

export GCP_PROJECT_ID=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_project_id")
export TF_VAR_gcp_project_id=$GCP_PROJECT_ID
export GCP_REGION=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_region")
export SERVICE_ACCOUNT_JSON=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_service_account")

 gcloud config configurations activate integ-tests

function googlecloud_enable_gcp_apis(){
  gcloud services enable \
    iam.googleapis.com \
    storage-api.googleapis.com \
    cloudresourcemanager.googleapis.com \
    compute.googleapis.com \
    serviceusage.googleapis.com \
    --project "${GCP_PROJECT_ID}"
}
