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

all: .plan
	@clear
	@echo "Applying infrastructure"
	$(tf) apply $(planfile)

destroy: .title .cleanup
	@clear
	@echo "Destroying environment"
	$(tf) destroy $(targetfile) --force -var "do_token=${DO_PAT}"
