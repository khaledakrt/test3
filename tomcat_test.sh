#!/bin/bash
#
# Check that Tomcat is running well
# Run this script after Tomcat installation

export ENVIRONMENT=$1

usage() {
    echo "Usage:  $0 <ENVIRONMENT>"
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi

echo ""
echo "Deploy Tomcat using Ansible"
echo "---------------------------"
ansible-playbook --extra-vars="env=${ENVIRONMENT}" /data/tomcat_deploy.yml
echo ""

echo "Check java process and parameters"
echo "---------------------------------"
ps -ef | grep java
echo ""

echo "Check Tomcat service status"
echo "---------------------------"
# Tomcat is started by the script, so checking the process instead
echo "Tomcat status: Running if 'java' process is found"
echo ""

echo "Check application home page"
echo "---------------------------"
curl http://localhost:8080/sample/
echo ""

echo "Check Tomcat logs"
echo "-----------------"
cat /opt/tomcat/logs/catalina.out
