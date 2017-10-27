resource "aws_security_group" "web-sg-1" {
  name		= "web-instance-security-group"
  ingress {
    from_port	= 80
    to_port	= 80
    protocol	= "tcp"
    cidr_blocks	= ["0.0.0.0/0"]
  }
  ingress {
    from_port	= 22
    to_port	= 22
    protocol	= "tcp"
   cidr_blocks	= ["0.0.0.0/0"]
  }
}

resource "aws_instance" "www-1" {
  ami = "ami-13e45c77"
  instance_type = "t2.micro"
  #security_groups = ["web-sg"]
  security_groups = ["${aws_security_group.web-sg-1.name}"]
  tags {
    Name = "www-1"
  }
}
