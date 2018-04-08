# version: 1
# Build Scaleway environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf = /home/cmills/bin/terraform
planfile = terraform_plan.tfplan
destroyfile = terraform_destroy.tfplan
repo=https://github.com/maxwayne-mills/ansible.git
repodir=ansible

.title:
	@clear
	@echo "Manage Scaleway infrastructure"
	@echo "====================================="
	@echo ""

.clone:
	@if [ -d "$(repodir)" ]; then rm -rf "$(repodir)"; fi
	@echo ""
	@echo "Cloning config management"
	@echo "========================="
	@echo ""
	@git clone --depth=1 $(repo)
	@echo ""
	@echo "Copying Ansible configuration file"
	@echo "=================================="
	@echo ""
	@cp ansible/ansible.cfg .

.check:
	@echo ""
	@echo "Checking terraform files for conformity and correctness"
	@echo "======================================================="
	@echo ""
	@$(tf) fmt
	@$(tf) validate
	@sleep 3

.int:
	@echo ""
	@echo "Initializing"
	@echo "============"
	@echo ""
	@@$(tf) init -input=false

.plan: 
	@echo ""
	@echo "Create build plan to file"
	@echo "========================="
	@echo ""
	@$(tf) plan -out=$(planfile)

.cleanup:
	@echo ""
	@echo "Cleaning up local environment"
	@echo "============================="
	@echo ""
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
	@echo ""
	#@$(tf) apply $(planfile)
	@$(tf) apply -input=false -auto-approve
	@make provision

apply: .title .check 
	@echo ""
	@echo "Applying infrastructure"
	@echo "======================="
	@echo ""
	@$(tf) apply 

destroy: .title
	@echo ""
	@echo "Destroying environment"
	@echo "======================"
	@echo ""
	@$(tf) destroy --force -auto-approve

show:
	@$(tf) show

clean: .cleanup

clone: .clone

provision:
	@sleep 15
	@echo ""
	@echo "Provisioning with Ansible"
	@echo "-------------------------"
	@ansible-playbook ansible/roles/common/common.yml

redo:
	@make destroy && make 

