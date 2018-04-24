#!/bin/bash

play=$(which ansible-playbook)

$play ansible/playbooks/publish_website.yml -e "server_name=srv1 domain_name=fixyourip.com repo_name=https://github.com/maxwayne-mills/fixyourip.com.git" -vvvv
