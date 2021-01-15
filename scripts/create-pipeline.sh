#!/usr/bin/env bash
echo
echo "==> **************************************************"
echo "==> "
echo "==> Create JFall 2020 workshop pipeline"
echo "==> "
echo "==> **************************************************"
echo

# Make sure the proper namespace is used
echo "==> Switching to project for this workshop"
oc project jfall-workshop
echo "==> Done!"

# Install the necessary pipline resources
echo "==> Creating Pipeline Resources for Git repo and target Docker image"
oc apply -f pipeline-resources.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else
  echo "==> Done!"
fi

# Creating the necessary pipeline tasks
echo
echo "==> Creating Pipeline Tasks"
oc apply -f compile-and-build.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
fi

oc apply -f deploy-using-kn.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else 
  echo "==> Done!"
fi

# Install the OpenShift pipelines operator
echo
echo "==> Creating Tekton Pipeline "
oc apply -f pipeline.yaml
RESPONSE=$?

if [ $RESPONSE -ne 0 ]; then
  exit 1
else 
  echo "==> Done!"
fi

echo
echo "==> ****************************************************"
echo "==> "
echo "==> Successfully created JFall 2020 workshop pipeline"
echo "==> "
echo "==> ****************************************************"
