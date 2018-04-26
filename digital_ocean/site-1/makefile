# version: 1
# Build Digital Ocean environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf =$(which terraform) 
planfile = terraform_plan.tfplan
token=do_token=${DO_PAT}
repo=https://github.com/maxwayne-mills/ansible.git
cloud_init_repo=https://github.com/maxwayne-mills/cloud_init.git
repodir=ansible
repo_cloudinit=cloud_init

.title:
	@echo ""
	@echo "Manage Digital Ocean infrastructure"
	@echo "====================================="

.clone:
	@echo ""
	@if [ -d "$(repodir)" ]; then rm -rf "$(repodir)"; fi
	@echo "Cloning config management"
	@echo "========================="
	@echo ""
	@git clone --depth=1 $(repo)
	@cp ansible/ansible.cfg .
	@echo ""
	@if [ -d "$(repo_cloudinit)" ]; then rm -rf "$(repo_cloudinit)"; fi
	@echo "Copying cloudinit configuration files"
	@echo "====================================="
	@echo ""
	@git clone --depth=1 $(cloud_init_repo)

.check:
	@echo ""
	@echo "Checking terraform files for conformity and correctness"
	@echo "======================================================="
	@echo ""
	@$(tf) fmt
	@$(tf) validate

.int:
	@echo ""
	@echo "Initializing"
	@echo "============"
	@@$(tf) init

.plan: 
	@echo ""
	@echo "Create build plan to file"
	@echo "========================="
	@echo ""
	@$(tf) plan -out=$(planfile) -var "do_token=${DO_PAT}"

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

all: .title .int .clone .check .plan
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

clone: .clone

init: .int
