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
.check:
	@echo "Checking terraform files for conformity and correctness"
	@$(tf) validate
	@$(tf) fmt

.plan: .title
	@echo "Initializing environment"
	@echo ""
	@$(tf) init
	@sleep 3

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
	@echo "Cleaning local environment"
	@rm *.tfplan

all: .title .check .plan
	@clear
	@echo "Applying infrastructure"
	@$(tf) apply $(planfile)

destroy: .title
	@clear
	@echo "Destroying environment"
	@echo ""
	#@$(tf) destroy $(destroyfile) --force -var "do_token=${DO_PAT}"
	@$(tf) destroy --force -var "do_token=${DO_PAT}"
	@echo " "
	@echo "Cleaning up"
	@echo ""

clean: .cleanup
