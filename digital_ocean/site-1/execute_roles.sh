#!/bin/bash

play=$(which ansible-playbook)

$play ansible/playbooks/publish_website.yml -e "server_name=srv1 domain_name=becomeonewiththecode.com repo_name=https://github.com/clarencemills/becomeonewiththecode.com.git" -vv
