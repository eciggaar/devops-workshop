#!/usr/bin/env bash
echo
echo "==> **************************************************"
echo "==> "
echo "==> Cleaning-up JFall 2020 workshop"
echo "==> "
echo "==> **************************************************"
echo

# Make sure the proper namespace is used
echo "==> Switching to project for this workshop"
oc project jfall-workshop
echo "==> Done!"

echo
echo "==> Delete all pipeline resources"
tkn resource delete --all -n jfall-workshop -f
echo "==> Done!"

echo
echo "==> Delete all pipeline tasks"
tkn task delete --all -n jfall-workshop -f
echo "==> Done!"

echo
echo "==> Delete all taskruns"
tkn taskrun delete --all -n jfall-workshop -f
echo "==> Done!"

echo
echo "==> Delete the pipeline"
tkn pipeline delete jfall-pipeline -n jfall-workshop -f
echo "==> Done!"

echo
echo "==> Delete all pipelineruns"
tkn pipelinerun delete --all -n jfall-workshop -f
echo "==> Done!"

echo
echo "==> Delete the JFall workshop project"
oc delete project jfall-workshop
echo "==> Done!"

echo
echo "==> ****************************************************"
echo "==> "
echo "==> Successfully cleaned-up JFall 2020 workshop"
echo "==> "
echo "==> ****************************************************"
