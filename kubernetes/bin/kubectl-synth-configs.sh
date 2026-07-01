#!/bin/sh
set -x

# This downloads some configs from Omni/Sidero for dev/stg/prd

cd ~/.kube/
omnictl config context dev
generate_kubeconfigs.sh '0007-05|0007-73|3030|0007-311'

# stage not stg, thank you sidero/omni/etc
omnictl config context stg
generate_kubeconfigs.sh '0001-12|0001-13|0001-73|0001-23|0001-33|0008-03|0001'

# prd
omnictl config context prd
generate_kubeconfigs.sh '0018|0060|0001|0008|0077|0117|0137|0137|9137|0003|0015-01|0015-04|0033-109|0116-01|0085-21|0090-08|0033-58|0033-97|0146-01|0047-02|0100-01|0032|0193'


# This merges all .yaml files in ~/.kube into one single kubeconfig.
# Switch configs with kubectx or with `kubectl config`.
KUBECONFIG="$HOME/.kube/config":$(find "$HOME/.kube" -type f -iname \*.yaml | tr '\n' ':') kubectl config view --flatten > "$HOME/.kube/config"

# GKE Cloud
gcloud container clusters get-credentials --region us-west2 gke-stg-powerflex-cluster --project edf-re-powerflex-stg-8019
gcloud container clusters get-credentials --region us-west2 gke-dev-powerflex-cluster --project edf-re-powerflex-dev-16b1
gcloud container clusters get-credentials --region us-west2 gke-prd-powerflex-cluster --project edf-re-powerflex-prd-4be3 

# GKE Cloud Nexus
gcloud container clusters get-credentials --region us-west2 gke-dev-powerflex-cloud-nexus --project powerflex-cloud-nexus-dev
gcloud container clusters get-credentials --region us-west2 gke-stg-powerflex-cloud-nexus --project powerflex-cloud-nexus-stg
gcloud container clusters get-credentials --region us-west2 gke-prd-powerflex-cloud-nexus --project powerflex-cloud-nexus-prd
