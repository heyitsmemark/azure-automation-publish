#!/bin/bash

set -e

if [ -z "$INPUT_ClientId" ]; then
  echo "ClientId is not set."
  exit 1
fi

if [ ! -z "$INPUT_ClientSecret" ]; then
  echo "ClientId is not set."
  exit 1
fi

if [ ! -z "$INPUT_TenantId" ]; then
  echo "TenantId is not set."
  exit 1
fi

if [ ! -z "$INPUT_AutomationAccountName" ]; then
  echo "AutomationAccountName is not set."
  exit 1
fi

if [ ! -z "$INPUT_AutomationAccountResourceGroup" ]; then
  echo "AutomationAccountResourceGroup is not set."
  exit 1
fi


az login --service-principal -u $INPUT_ClientId -p $INPUT_ClientSecret --tenant $INPUT_TenantId

for fullfile in ./*.ps1; do
    basefile=$(basename -- "$fullfile")
    filename="${basefile%.*}"

    az automation runbook create  -g automation --automation-account-name aa-plop --runbook-name ${filename} --type PowerShell
    az automation runbook replace-content --content @./${basefile} --automation-account-name aa-plop -g automation --name ${filename}
    az automation runbook publish --automation-account-name aa-plop -g automation --name ${filename}
done

az logout