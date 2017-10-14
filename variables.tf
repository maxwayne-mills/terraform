variable "region" {
  type = "string"
  description = "The AWS region"
  default = "ca-central-1"
}

variable "ami-type" {
  type = "string"
  description = "Ami type"
  default = "t2.micro"
}
