#!/usr/bin/env bash
echo
echo "==> **************************************************"
echo "==> "
echo "==> Installing DevOps workshop pre-requisites"
echo "==> "
echo "==> **************************************************"
echo

# Install the OpenShift pipelines operator
echo "==> Installing the openshift pipelines operator..."
oc apply -f ./operators/oc-pipelines-sub.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else
  echo "==> Done!"
fi

# Install the OpenShift serverless operator
echo
echo "==> Installing the openshift serverless operator..."
oc apply -f ./operators/oc-serverless-sub.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else
  # serverless operator is installed, so now complete installation by installing the Knative Serving API
  STATE=`oc get subscription serverless-operator -n openshift-operators -o json |jq -r '.status."state"'`

  until [ $STATE == "AtLatestKnown" ]
  do
    if [ $STATE == "null" ]; then
      echo "  waiting for completion..."
    else
      echo "  waiting for completion...current state: $STATE"
    fi

    STATE=`oc get subscription serverless-operator -n openshift-operators -o json |jq -r '.status."state"'`
    sleep 2;
  done;
  
  echo "==> Done!" 
  echo
  echo "==> Installing Knative serving API..."
  oc create namespace knative-serving
  oc apply -f ./knative/knative-serving.yaml
  RESPONSE=$?
  
  if [ $RESPONSE -ne 0 ]; then
    exit 1
  else
    # Pause 10 seconds, then query to see whether knative pane successfully installed. After 10 seconds the conditions representing the installation progress
    # in the output JSON should be present
    for i in {0..9}
    do
      echo "  waiting for completion..."
      sleep 2;
    done;

    STATE=`oc get knativeserving.operator.knative.dev/knative-serving -n knative-serving -o json | jq '.status."conditions" | .[] | select (.type == "Ready")'`
    
    until `echo $STATE | jq '.status == "True"'`
    do
      echo $STATE |jq 
      sleep 3;
      STATE=`oc get knativeserving.operator.knative.dev/knative-serving -n knative-serving -o json | jq '.status."conditions" | .[] | select (.type == "Ready")'`
    done; 

    echo
    oc get knativeserving.operator.knative.dev/knative-serving -n knative-serving --template='{{range .status.conditions}}{{printf "%s=%s\n" .type .status}}{{end}}'
    echo
    echo "==> Done!"
  fi
fi

echo
echo "==> Creating the OpenShift project for this workshop"
oc new-project devops-workshop
echo "==> Done!"

echo
echo "==> ****************************************************"
echo "==> "
echo "==> Successfully installed DevOps workshop pre-reqs"
echo "==> "
echo "==> ****************************************************"
