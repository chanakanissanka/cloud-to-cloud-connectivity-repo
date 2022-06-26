UNAME:= $(shell uname)
ifeq ($(UNAME),Darwin)
		OS_X  := true
		SHELL := /bin/bash
else
		OS_DEB  := true
		SHELL := /bin/bash
endif

TERRAFORM:= $(shell command -v terraform 2> /dev/null)

all: azplan awsplan

azplan:
	cd ./azure; terraform plan; terraform apply -auto-approve; terraform apply -auto-approve; terraform output > ../aws/terraform.tfvars
	
	
awsplan:
	cd ./aws; terraform plan; terraform apply -var-file=terraform.tfvars -auto-approve


clean:
	cd ./azure; terraform destroy -auto-approve; cd ../aws/; terraform destroy -auto-approve;
	