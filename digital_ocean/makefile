# version: 1
# Build Digital Ocean environment
# Set DO_PAT variable by exporting digital ocean token into environmental variable
# export DO_PAT="" 

tf = /home/cmills/bin/terraform
planfile = terraform_plan.tfplan
destroyfile = terraform_destroy.tfplan
do_token=$(DO_PAT)

.title:
	clear
	@echo "Manage Digital Ocean infrastructure\n"
	@sleep 2

.clone:
	@clear
	@echo "Cloning config management"
	git clone https://github.com/maxwayne-mills/config-managment.git
	@sleep 20
	cp config-managment/ansible.cfg .

.plan: .title
	@echo "Initializing environment"
	$(tf) init
	@sleep 3

	clear
	@echo "Create build plan to file"
	$(tf) plan -out=$(planfile) -var "do_token=${DO_PAT}"
	@sleep 3

	clear
	@echo "Create destroy plan to file"
	$(tf) plan -out=$(destroyfile) -var "do_token=${DO_PAT}"

.cleanup:
	@rm *.tfplan
	@rm -rf config-managment
	@rm ansible.cfg inventory

all: .clone .plan
	@clear
	@echo "Applying infrastructure"
	$(tf) apply $(planfile)

destroy: .title .cleanup
	@clear
	@echo "Destroying environment"
	$(tf) destroy $(targetfile) --force -var "do_token=${DO_PAT}"

cleanup: .cleanup

