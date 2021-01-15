#!/usr/bin/env bash
echo
echo "==> **************************************************"
echo "==> "
echo "==> Deleting JFall 2020 workshop pre-requisites"
echo "==> "
echo "==> **************************************************"
echo

# Delete the OpenShift pipelines operator subscription
echo "==>  Deleting openshift pipelines operator subscription..."
echo "  get current cluster service version of pipelines operator:"
CURRENTCSV=`oc get subscription openshift-pipelines-operator-rh -n openshift-operators -o json |jq -r '.status."currentCSV"'`

echo "  delete the operator subscription..."
oc delete subscription openshift-pipelines-operator-rh -n openshift-operators

echo "  delete the cluster service version of the operator"
oc delete clusterserviceversion $CURRENTCSV -n openshift-operators

# Delete the OpenShift serverless operator subscription
echo
echo "==>  Deleting openshift serverless operator subscription..."
echo "  deleting Knative serving"
oc delete knativeservings.operator.knative.dev knative-serving -n knative-serving

echo "  deleting knative-serving namespace"
oc delete namespace knative-serving

echo "  get current cluster service version of serverless operator:"
CURRENTCSV=`oc get subscription serverless-operator -n openshift-operators -o json |jq -r '.status."currentCSV"'`

echo "  delete the operator subscription..."
oc delete subscription serverless-operator -n openshift-operators

echo "  delete the cluster service version of the operator"
oc delete clusterserviceversion $CURRENTCSV -n openshift-operators

echo "  delete remaining Knative custom resource definitions (CRDs)"
oc get crd -oname | grep 'knative.dev' | xargs oc delete

echo
echo "==> ****************************************************"
echo "==> "
echo "==> Successfully deleted JFall 2020 workshop pre-reqs"
echo "==> "
echo "==> ****************************************************"


