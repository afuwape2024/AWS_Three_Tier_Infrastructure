#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-dev}"
AWS_REGION="${AWS_REGION:-us-east-2}"
WORKING_DIR="realproject/3tier/env/${ENVIRONMENT}"

echo "======================================"
echo "Starting Terraform deployment"
echo "Environment : ${ENVIRONMENT}"
echo "Region      : ${AWS_REGION}"
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

if ! command -v aws >/dev/null 2>&1; then
  echo "ERROR: aws CLI is not installed or not in PATH."
  exit 1
fi

echo "Checking AWS caller identity..."
aws sts get-caller-identity >/dev/null

cd "${WORKING_DIR}"

echo "Running terraform fmt check..."
terraform fmt -check -recursive || true

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform..."
terraform validate

echo "Planning Terraform changes..."
terraform plan -out=tfplan

echo "Applying Terraform changes..."
terraform apply -auto-approve tfplan

echo "Deployment completed successfully for ${ENVIRONMENT}."