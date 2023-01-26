#!/bin/bash

set -e

if [ -z "$CLIENTID" ]; then
  echo "ClientId is not set."
  exit 1
fi

if [ ! -z "$INPUT_CLIENTSECRET" ]; then
  echo "ClientId is not set."
  exit 1
fi

if [ ! -z "$INPUT_TENANTID" ]; then
  echo "TenantId is not set."
  exit 1
fi

if [ ! -z "$INPUT_AUTOMATIONACCOUNTNAME" ]; then
  echo "AutomationAccountName is not set."
  exit 1
fi

if [ ! -z "$INPUT_AUTOMATIONACCOUNTRESOURCEGROUP" ]; then
  echo "AutomationAccountResourceGroup is not set."
  exit 1
fi


az login --service-principal -u $INPUT_CLIENTID -p $INPUT_CLIENTSECRET --tenant $INPUT_TENANTID

for fullfile in ./*.ps1; do
    basefile=$(basename -- "$fullfile")
    filename="${basefile%.*}"

    az automation runbook create  -g ${INPUT_AUTOMATIONACCOUNTRESOURCEGROUP} --automation-account-name ${INPUT_AUTOMATIONACCOUNTNAME} --runbook-name ${filename} --type PowerShell
    az automation runbook replace-content --content @./${basefile} --automation-account-name ${INPUT_AUTOMATIONACCOUNTNAME} -g ${INPUT_AUTOMATIONACCOUNTRESOURCEGROUP} --name ${filename}
    az automation runbook publish --automation-account-name ${INPUT_AUTOMATIONACCOUNTNAME} -g ${INPUT_AUTOMATIONACCOUNTRESOURCEGROUP} --name ${filename}
done

az logout
