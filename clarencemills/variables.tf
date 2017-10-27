variable "aws_region" {
  description = "The region where to launch"
  default = "ca-central-1"
}

variable "web_instance_type" {
  description = "Type of ec2 instance"
  default = "t2.micro"
}
