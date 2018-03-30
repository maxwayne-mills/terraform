# version: 1
# Build Scaleway environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf = /home/cmills/bin/terraform
planfile = terraform_plan.tfplan
destroyfile = terraform_destroy.tfplan
token=do_token=${DO_PAT}
repo=https://github.com/maxwayne-mills/ansible.git
repodir=ansible

.title:
	@clear
	@echo "Manage Digital Ocean infrastructure"
	@echo "====================================="
	@echo ""
	@sleep 2

.clone:
	@clear
	if [ -d "$(repodir)" ]; then rm -rf "$(repodir)"; fi
	@echo ""
	@echo "Cloning config management"
	@echo "========================="
	@echo ""
	@git clone $(repo)
	@echo ""
	@sleep 20
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
	@@$(tf) init
	@sleep 3

.plan: 
	@echo ""
	@echo "Create build plan to file"
	@echo "========================="
	@echo ""
	@$(tf) plan -out=$(planfile) -var "do_token=${DO_PAT}"
	@sleep 3

.cleanup:
	@echo "Cleaning up local environment"
	@echo "============================="
	@echo ""
	@if [ -d $(repodir) ]; then rm -rf $(repodir); fi
	@if [ -f ansible.cfg ]; then rm ansible.cfg; fi
	@if [ -f inventory ]; then rm inventory; fi
	@if [ -f "*.tfplan" ]; then rm *.tfplan.*; fi
	@if [ -f "*.tfstate" ]; then rm *.tfstate*; fi
	@if [ -d ".terraform" ]; then rm -rf .terraform; fi
	@echo ""
	@echo "cleanup completed"

all: .title .int .check .clone .plan
	@clear
	@echo "Applying infrastructure"
	@echo "======================="
	@echo ""
	@$(tf) apply $(planfile)

redo: .title .check 
	@clear
	@echo "Applying infrastructure"
	@echo "======================="
	@echo ""
	@$(tf) apply -var "do_token=${DO_PAT}"

destroy: .title
	@clear
	@echo "Destroying environment"
	@echo "======================"
	@echo ""
	@$(tf) destroy -var "do_token=${DO_PAT}"
	@echo "Cleaning up"
	@echo ""

clean: .cleanup
