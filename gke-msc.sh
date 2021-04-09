#!/bin/sh
# ./gke-msc.sh <project> <zone> <clustername>
gcloud services enable gkehub.googleapis.com --project $1
gcloud services enable dns.googleapis.com --project $1
gcloud services enable trafficdirector.googleapis.com --project $1
gcloud services enable cloudresourcemanager.googleapis.com --project $1
gcloud services enable multiclusterservicediscovery.googleapis.com --project $1

gcloud alpha container hub multi-cluster-services enable --project voxo-5060
gcloud container hub memberships register "$3" --gke-cluster "$2"/"$3" --enable-workload-identity
gcloud projects add-iam-policy-binding voxo-5060 --member "serviceAccount:$1.svc.id.goog[gke-mcs/gke-mcs-importer]" --role "roles/compute.networkViewer"
gcloud alpha container hub multi-cluster-services describe