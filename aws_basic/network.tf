resource "aws_vpc" "test" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "Test VPC"
  }
}

resource "aws_security_group" "test_instance" {
  name        = "security-group allow_ssh"
  description = "Allow inbound ssh and allow all traffic out"

  ingress {
    description = "allow port 22 in"
    from_port   = 22
    to_port     = 2233
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow port 80 in"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ## THis is needed as Terraform when creating a new Security Group inside a VPC, Terraform will remove the default egress rule. So it needs to be added
  egress {
    description = "allow all outbound traffic to the internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
