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

  ## This is needed because Terraform when creating a new Security Group inside a VPC, will remove the default egress rule. So it needs to be added back
  egress {
    description = "allow all outbound traffic to the internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test_ec2" {
  ami                    = "${var.ami_name}"
  instance_type          = "${var.instance_name}"
  key_name               = "cmills-key"
  vpc_security_group_ids = ["${aws_security_group.test_instance.id}"]

  tags {
    Name = "Test instance"
  }

  user_data = "apt-get update -y"
}
