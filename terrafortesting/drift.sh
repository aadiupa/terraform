#!/bin/bash
terraform plan --var="environment=$1" --detailed-exitcode -out=tf.plan 2> /dev/null || ec=$?
case $ec in 
0) echo "No Changes Found": exit 0;;
1) printf '%s/n' "Command exited with non-zero";exit 1;;
2) echo "Changes found";
	echo "Contact DevOps Team"
esac
