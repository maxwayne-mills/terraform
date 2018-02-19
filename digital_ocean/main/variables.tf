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
