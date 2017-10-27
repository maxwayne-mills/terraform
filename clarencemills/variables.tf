variable "aws_region" {
  description = "The region where to launch"
  default = "ca-central-1"
}

variable "aws_nat_region" {
  description = "The region where to launch nat instance"
  default = "ca-central-1b"
}

variable "aws_key_name" {
  description = "Key name"
  default = "aws_key"
}

variable "aws_key_path" {
  description = "path to public"
  default = "~/.ssh/id_rsa.pub"
}

variable "nat_ami" {
 description = "Ami used for nat device"
  default = "ami-13e45c77"
}

variable "web_instance_type" {
  description = "Type of ec2 instance"
  default = "t2.micro"
}

variable "private_subnet_cidr" {
  description = "Private subnet"
  default = "10.1.2.0/24"
}

variable "public_subnet_cidr" {
  description = "Public subnet"
  default = "10.1.1.0/24"
}
