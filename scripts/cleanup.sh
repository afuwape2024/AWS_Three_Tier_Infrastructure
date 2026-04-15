#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-dev}"
WORKING_DIR="realproject/3tier/env/${ENVIRONMENT}"

echo "======================================"
echo "Starting Terraform cleanup"
echo "Environment : ${ENVIRONMENT}"
echo "Directory   : ${WORKING_DIR}"
echo "======================================"

if [[ ! -d "${WORKING_DIR}" ]]; then
  echo "ERROR: Terraform directory '${WORKING_DIR}' does not exist."
  exit 1
fi

if ! command -v terraform >/dev/null 2>&1; then
  echo "ERROR: terraform is not installed or not in PATH."
  exit 1
fi

read -r -p "Are you sure you want to destroy ${ENVIRONMENT}? Type 'yes' to continue: " CONFIRM

if [[ "${CONFIRM}" != "yes" ]]; then
  echo "Cleanup cancelled."
  exit 0
fi

cd "${WORKING_DIR}"

echo "Initializing Terraform..."
terraform init

echo "Destroying Terraform-managed infrastructure..."
terraform destroy -auto-approve

echo "Cleanup completed for ${ENVIRONMENT}."