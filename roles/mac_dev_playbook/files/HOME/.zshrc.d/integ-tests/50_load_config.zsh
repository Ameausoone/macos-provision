#!/usr/bin/env zsh

# Load config for integ tests
# shellcheck disable=SC2155
function integ_tests_load_config(){
  export GCP_PROJECT_ID=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_project_id")
  export TF_VAR_gcp_project_id=$GCP_PROJECT_ID
  export GCP_REGION=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_region")
  export SERVICE_ACCOUNT_JSON=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_service_account")
  gcloud config configurations activate integ-tests
  export INTEG_TESINTEG_TESTS_LOADED_CONFIGTS_LOADED_CONFIG="true"
}

function googlecloud_enable_gcp_apis(){
  gcloud services enable \
    iam.googleapis.com \
    storage-api.googleapis.com \
    cloudresourcemanager.googleapis.com \
    compufte.googleapis.com \
    serviceusage.googleapis.com \
    --project "${GCP_PROJECT_ID}"
}
