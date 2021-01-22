#!/usr/bin/env bash
echo
echo "==> **************************************************"
echo "==> "
echo "==> Cleaning-up DevOps workshop"
echo "==> "
echo "==> **************************************************"
echo

# Make sure the proper namespace is used
echo "==> Switching to project for this workshop"
oc project devops-workshop
echo "==> Done!"

echo
echo "==> Delete all pipeline resources"
tkn resource delete --all -n devops-workshop -f
echo "==> Done!"

echo
echo "==> Delete all pipeline tasks"
tkn task delete --all -n devops-workshop -f
echo "==> Done!"

echo
echo "==> Delete all taskruns"
tkn taskrun delete --all -n devops-workshop -f
echo "==> Done!"

echo
echo "==> Delete the pipeline"
tkn pipeline delete workshop-pipeline -n devops-workshop -f
echo "==> Done!"

echo
echo "==> Delete all pipelineruns"
tkn pipelinerun delete --all -n devops-workshop -f
echo "==> Done!"

echo
echo "==> Delete the DevOps workshop project"
oc delete project devops-workshop
echo "==> Done!"

echo
echo "==> ****************************************************"
echo "==> "
echo "==> Successfully cleaned-up DevOps workshop"
echo "==> "
echo "==> ****************************************************"
