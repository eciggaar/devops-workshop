#!/usr/bin/env bash
echo
echo "==> **************************************************"
echo "==> "
echo "==> Create DevOps workshop pipeline"
echo "==> "
echo "==> **************************************************"
echo

# Make sure the proper namespace is used
echo "==> Switching to project for this workshop"
oc project devops-workshop
echo "==> Done!"

# Install the necessary pipline resources
echo "==> Creating a Tekton workspace to share resources between the different pipeline tasks"
oc apply -f tekton/workspaces/source-pvc/pvc.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else
  echo "==> Done!"
fi

echo "==> Creating a Maven ConfigMap with settings.xml"
oc create cm maven-settings --from-file=tekton/workspaces/maven-settings/settings.xml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else
  echo "==> Done!"
fi


# Creating the necessary pipeline tasks
echo
echo "==> Adding a custom Tekton task to clean up the workspace as last step of the pipeline"
oc apply -f tekton/custom-tasks/workspace-cleaner.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else 
  echo "==> Done!"
fi

# Creating the OpenShift Pipeline for the workshop
echo
echo "==> Creating workshop OpenShift Pipeline"
oc apply -f tekton/pipelines/pipeline.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else 
  echo "==> Done!"
fi

echo
echo "==> ****************************************************"
echo "==> "
echo "==> Successfully created DevOps workshop pipeline"
echo "==> "
echo "==> ****************************************************"
