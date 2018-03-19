# version: 1
# Build Digital Ocean environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf = /home/cmills/bin/terraform
planfile = terraform_plan.tfplan
token=do_token=${DO_PAT}
repo=https://github.com/maxwayne-mills/ansible.git
repo_cloudinit=https://github.com/maxwayne-mills/cloud_init.git
repodir=ansible

.title:
	@clear
	@echo "Manage Digital Ocean infrastructure"
	@echo "====================================="
	@echo ""
	@sleep 2

.clone:
	@clear
	@if [ -d "$(repodir)" ]; then rm -rf "$(repodir)"; fi
	@if [ -d "$(repo_cloudinit)" ]; then rm -rf "$(repo_cloudinit)"; fi
	@echo ""
	@echo "Cloning config management"
	@echo "========================="
	@echo ""
	@git clone $(repo)
	@echo ""
	@sleep 20
	@cp ansible/ansible.cfg .
	@echo "Copying cloudinit configuration files"
	@echo "====================================="
	@echo ""
	@git clone $(repo_cloudinit)

.check:
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
	@if [ -d $(repodir) ]; then rm -rf $(repodir); fi
	@if [ -f ansible.cfg ]; then rm ansible.cfg; fi
	@if [ -f inventory ]; then rm inventory; fi
	@if [ -f .tfplan ]; then rm *.tfplan.*; fi
	@if [ -f .tfstate ]; then rm *.tfstate*; fi
	@if [ -d .terraform ]; then rm -rf .terraform; fi
	@echo "cleanup completed"

all: .title .clone .int .check .plan
	@clear
	@echo "Applying infrastructure"
	@echo "======================="
	@echo ""
	@$(tf) apply $(planfile)

update: .title .check 
	@clear
	@rm -rf ansible ansible.cfg
	@git clone $(repo)
	@echo "Updating infrastructure"
	@echo "======================="
	@echo ""
	@$(tf) apply -var "do_token=${DO_PAT}"

destroy: .title
	@clear
	@echo "Destroying environment"
	@echo "======================"
	@echo ""
	@$(tf) destroy -force -var "do_token=${DO_PAT}"
	@rm -rf .terraform
	@rm terraform*
	@if [ -f inventory ]; then rm inventory; fi
	@rm -rf ansible
	@rm -rf cloud_init
	@echo "Cleaning up"
	@echo ""

show:
	@$(tf) show

clean: .cleanup

validate: .int .check 

plan: .int .plan
