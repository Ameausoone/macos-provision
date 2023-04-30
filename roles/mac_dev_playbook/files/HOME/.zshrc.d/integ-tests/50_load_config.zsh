#!/usr/bin/env zsh

export GCP_PROJECT_ID=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_project_id")
export GCP_REGION=$(creds_get_local_secret "com.ameausoone.integ.tests" "gcp_region")
