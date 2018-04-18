variable "region" {
  description = "Region"
  default     = "ams1"
}

variable "scaleway_type" {
  description = "Type of Cloud image"
  default     = "VC1S"
}

# obtain list of images using scw cli
variable "image_os" {
  description = "Image name"
  default     = "Ubuntu_Zesty"
}

variable "image_arch" {
  description = "Architecture"
  default     = "x86_64"
}

variable "server_name" {
  description = "Server Name"
  default     = "srv-1"
}
