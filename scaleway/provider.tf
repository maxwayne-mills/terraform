# You need to export the items below to authenticate to the Scaleway platform
# export SCALEWAY_ORGANIZATION=""
# export SCALEWAY_TOKEN=""
# If you create an infrastructure with a token and then delete the token without deleting the infrastructure
# you will have to delete the infrastructure manually.

# Don't include either the scaleway_organization or token within this file, 
#read it from env variables. It will generate an error if you do.

provider "scaleway" {
  region = "${var.region}"
}
