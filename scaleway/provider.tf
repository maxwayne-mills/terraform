# You need to export the items below to authenticate to the Scaleway platform
# export SCALEWAY_TOKEN=""
# export SCALEWAY_TOKEN=""
# If you create an infrastructure with a token and then delete the token without deleting the infratstructure
# you will have to delete the infrastructure manually.

provider "scaleway" {
  region = "${var.region}"
}
