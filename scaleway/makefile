# version: 1
# Build Scaleway environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf = /home/cmills/bin/terraform
planfile = terraform_plan.tfplan
repo=https://github.com/maxwayne-mills/ansible.git
shell_repo=https://github.com/maxwayne-mills/shell_scripts.git
repodir=ansible
shell_repo_dir=shell_scripts

.title:
	@clear
	@echo "Manage Scaleway infrastructure"
	@echo "====================================="
	@echo ""

.clone:
	@if [ -d "$(repodir)" ]; then rm -rf "$(repodir)"; fi
	@if [ -d "$(shell_repo_dir)" ]; then rm -rf "$(shell_repo_dir)"; fi
	@echo ""
	@echo "Cloning Ansible repository"
	@echo "========================="
	@echo ""
	@git clone --depth=1 $(repo)
	@echo ""
	@echo "Cloning Shell script repository"
	@echo "=================================="
	@echo ""
	@git clone --depth=1 $(shell_repo)

.config:
	@shell_scripts/ansible_config_setup.sh

.check:
	@echo ""
	@echo "Checking terraform files for conformity and correctness"
	@echo "======================================================="
	@$(tf) fmt
	@$(tf) validate
	@sleep 3

.int:
	@echo ""
	@echo "Initializing"
	@echo "============"
	@@$(tf) init -input=false

.plan: 
	@echo ""
	@echo "Create build plan to file"
	@echo "========================="
	@$(tf) plan -out=$(planfile)

.cleanup:
	@echo ""
	@echo "Cleaning up local environment"
	@echo "============================="
	@if [ -d $(repodir) ]; then rm -rf $(repodir); fi
	@if [ -f ansible.cfg ]; then rm ansible.cfg; fi
	@if [ -f inventory ]; then rm inventory; fi
	@if [ -f "*.tfplan*" ]; then rm *.tfplan.*; fi
	@if [ -f "*.tfstate*" ]; then rm *.tfstate*; fi
	@if [ -d ".terraform" ]; then rm -rf .terraform; fi
	@echo ""
	@echo "cleanup completed"

all: .title .int .check .clone .plan
	@echo ""
	@echo "Applying infrastructure"
	@echo "======================="
	#@$(tf) apply $(planfile)
	@$(tf) apply -input=false -auto-approve
	@make provision

apply: .title .check 
	@echo ""
	@echo "Applying infrastructure"
	@echo "======================="
	@$(tf) apply 

destroy: .title
	@echo ""
	@echo "Destroying environment"
	@echo "======================"
	@$(tf) destroy --force -auto-approve
	@rm -rf terraform*
	@rm -rf ansible shell_scripts .terraform
	@rm ansible.cfg inventory

show:
	@$(tf) show

clean: .cleanup

clone: .clone

provision:
	@sleep 15
	@echo ""
	@echo "Provisioning with Ansible"
	@make config
	@echo "-------------------------"
	@ansible-playbook ansible/roles/common/common.yml

reload:
	@make destroy && make

config: .config