# version: 1
# Build Digital Ocean environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf = /home/cmills/bin/terraform
planfile = terraform_plan.tfplan
destroyfile = terraform_destroy.tfplan
token=do_token=${DO_PAT}

.title:
	@clear
	@echo "Manage Digital Ocean infrastructure"
	@echo "====================================="
	@echo ""
	@sleep 2

.clone:
	@clear
	@echo "Cloning config management"
	@echo "========================="
	@echo ""
	@git clone https://github.com/maxwayne-mills/config-managment.git
	@echo ""
	@sleep 20
	@echo "Copying Ansible configuration file"
	@echo "=================================="
	@echo ""
	@cp config-managment/ansible.cfg .

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

	@echo ""
	@echo "Create destroy plan to file"
	@echo "==========================="
	@echo ""
	@$(tf) plan -out=$(destroyfile) -var "do_token=${DO_PAT}"
	@$(tf) plan -out=$(destroyfile) -var $(token)

.cleanup:
	@echo "Cleaning up local environment"
	@echo "============================="
	@echo ""
	@rm -rf config-managment
	@rm ansible.cfg inventory
	@rm *.tfplan

all: .title .int .check .clone .plan
	@clear
	@echo "Applying infrastructure"
	@echo "======================="
	@echo ""
	@$(tf) apply $(planfile)

destroy: .title
	@clear
	@echo "Destroying environment"
	@echo "======================"
	@echo ""
	@$(tf) destroy -var "do_token=${DO_PAT}"
	@echo "Cleaning up"
	@echo ""

clean: .cleanup
