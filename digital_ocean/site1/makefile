# version: 1
# Build Digital Ocean environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf = /home/cmills/bin/terraform
planfile = terraform_plan.tfplan
destroyfile = terraform_destroy.tfplan
do_token=$(DO_PAT)

.title:
	@clear
	@echo "Manage Digital Ocean infrastructure\n"
	@sleep 2

.clone:
	@clear
	@echo "Cloning config management"
	git clone https://github.com/maxwayne-mills/config-managment.git
	@sleep 20
	cp config-managment/ansible.cfg .

.check:
	@echo "Checking terraform files for conformity and correctness"
	@$(tf) validate
	@$(tf) fmt

.int:
	@echo "Initializing"
	@echo "============"
	@echo ""
	@@$(tf) init
	@sleep 3

.plan: 
	@clear
	@echo "Create build plan to file"
	@echo ""
	@$(tf) plan -out=$(planfile) -var "do_token=${DO_PAT}"
	@sleep 3

	@clear
	@echo "Create destroy plan to file"
	@echo ""
	@$(tf) plan -out=$(destroyfile) -var "do_token=${DO_PAT}"

.cleanup:
	@echo "Cleaning up local environment"
	@rm *.tfplan
	@rm -rf config-managment
	@rm ansible.cfg inventory

all: .title .int .check .clone .plan
	@clear
	@echo "Applying infrastructure"
	@$(tf) apply $(planfile)

destroy: .title
	@clear
	@echo "Destroying environment"
	@echo ""
	#$(tf) apply $(destroyfile) -var "do_token=${DO_PAT}"
	$(tf) destroy --force -var "do_token=${DO_PAT}"
	@echo " "
	@echo "Cleaning up"
	@echo ""

clean: .cleanup