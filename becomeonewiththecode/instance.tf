resource "aws_vpc" "bcode" {
  cidr_block = "10.1.0.0/16"
  tags {
    Name = "become one with the code"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id      = "${aws_vpc.bcode.id}"
  cidr_block  = "10.1.1.0/24"
  tags {
    Name = "private-1"
  }
}

resource "aws_security_group" "access_web_sg" {
  name		= "web-instance-security-group"
  vpc_id  = "${aws_vpc.bcode.id}"
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
  subnet_id = "${aws_subnet.private-1.id}"
  security_groups = ["${aws_security_group.access_web_sg.id}"]
  tags {
    Name = "www-1"
  }
}
