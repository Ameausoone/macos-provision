#!/usr/bin/env zsh

function check_gcloud_authenticated () {
  if ! check_cli_requirements ; then
    return 1
  fi
  if ! gcloud auth print-access-token 2>&1 >/dev/null; then
		echo "⛈️ ERROR ⛈️: You do not seem auth against gcloud, please run [gcloud auth login --update-adc], then [load_cpe_secrets]"
    return 1
	else \
		echo "✨ You are authenticated to GCP ✨"
	fi
}
