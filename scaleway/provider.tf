# You need to export the items below to authenticate to the Scaleway platform
# export SCALEWAY_TOKEN=""
# export SCALEWAY_TOKEN=""

provider "scaleway" {
  region = "${var.region}"
}
