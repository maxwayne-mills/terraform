variable "region" {
  description = "Region"
  default     = "ams1"
}

variable "scaleway_type" {
  description = "Type of Cloud image"
  default     = "c1"
}

variable "image_os" {
  description = "Image name"
  default     = "Ubuntu Precise" # obtain list of images using scw cli 
}

variable "image_arch" {
  description = "Architecture"
  default     = "arm"
}

variable "server_name" {
  description = "Server Name"
  default     = "www-1"
}
