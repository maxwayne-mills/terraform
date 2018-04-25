variable "do_token" {
  description = "Digital ocean token"
  default     = ""                    # taken from environmental variable DO_PAT
}

variable "ssh_key_name" {
  description = "Key name"
  default     = "cmills_key"
}

variable "ssh_fingerprint" {
  description = "SSH key fingerprint"
  default     = "6c:3c:f2:57:ed:b6:56:56:91:d2:84:e2:06:c7:43:d6"
}

variable "ssh_key_path" {
  description = "Path to ssh key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "region" {
  description = "Asset region"
  default     = "nyc3"
}

variable "droplet_memory_size" {
  description = "Droplet memory size"
  default     = "1gb"
}

variable "droplet_image" {
  description = "Image name"
  default     = "ubuntu-14-04-x64"
}

variable "websrv_name" {
  description = "web server name"
  default     = "web-server-1"
}

variable "ttl_life" {
  description = "TTL time in seconds"
  default     = "30"
}

variable "web_domain1" {
  description = "Domain name"
  default     = "millsresidence.com"
}

variable "web_domain2" {
  description = "Domain name"
  default     = "toolsforthecloud.com"
}

variable "web_domain4" {
  description = "Domain name"
  default     = "neatandfine.com"
}

variable "web_domain6" {
  description = "Domain name"
  default     = "opensitesolutions.com"
}
