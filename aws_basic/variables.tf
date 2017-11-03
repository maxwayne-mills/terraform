variable "aws_region" {
  description = "The region where to launch"
  default     = "ca-central-1"
}

variable "public_key_path" {
  description = "Public key"
  default     = "/home/cmills/.ssh/id_rsa.pub"
}

variable "ami_name" {
  description = "Ami used"
  default     = "ami-13e45c77"
}

variable "instance_name" {
  description = "Type of ec2 instance"
  default     = "t2.micro"
}
