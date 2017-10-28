resource "aws_key_pair" "cmills" {
  key_name  = "cmills-key"
  public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDN+JBPWHbViSin0QhZwllakXSTjE+6memHlokEL4hKbIQIyETKv//iZVUCE1lDnc0uE73cDKS8HVHR4S3N2WWHzeuStWIDnirOHE4SW3GgeQfu1H1DikHf7E+PT8qJhQWtAYzEJyFf4vgPn/KuNhJFRWXmR3zK3gACZWP1ON9fymoBzi5MG9YM44JJnGoYM3CX7Aav/1DwIR5Sc1jRJ6uxJTsH1qv7EC81hjmvMAT+DscD5yx5yU28VJ3LM0p2RrRDaZcjXGYviXUoXufZl9MbKrsya9nRrL4wiUgECrgbkYy3XJNN4LYZT9oeRqqzyU3H9N33of7KhcR78fPbt6dxq56f+gSNHOsImTLPsbfKMoRg01j1Pi3ambAdBaA9XLKfCn4rCNXVmjJ8CGuYCf2SW8ur9DG/v43PVeZerhdQJ6Jgg6nilJoqUBA38B6cFFuyNkK1DH8wRq2b55khEEKCRUA3jcvz44N7VD4SJfWr9vDz0xlpUgKTMijDg3/5RHmS6yGfE9fw0CHucRMF1z6gYjyyjpPkDcceobnS+370efsF/qfKXao4bfkHm+vUSfZlz5KfuLjggYjZzmKTTM50oJyrHgcOpxUvqJH2OWKiTHX8bVdlh/amzrALqr1zCg0amMulKmU4K4ucGUwWUF/m6aMgwA42HtAHSEc35oF3GQ== oss@cmills-Kudu-Pro"
}

resource "aws_vpc" "bcode" {
  cidr_block = "10.1.0.0/16"
  enable_dns_support  = true
  tags {
    Name = "become one with the code"
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

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id  = "${aws_vpc.bcode.id}"
}

resource "aws_route_table" "outbound_route" {
  vpc_id  = "${aws_vpc.bcode.id}"
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = "${aws_internet_gateway.internet_gateway.id}"
    }
  tags {
    Name  = "outbound_route"
    }
}

resource "aws_subnet" "private-1" {
  vpc_id      = "${aws_vpc.bcode.id}"
  cidr_block  = "10.1.1.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ca-central-1b"
  tags {
    Name = "private-1"
  }
}

resource "aws_subnet" "public-1" {
  vpc_id  = "${aws_vpc.bcode.id}"
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ca-central-1b"
  tags {
    Name = "public-1"
  }
}

resource "aws_route_table_association" "outbound_to_internet_gw" {
  subnet_id = "${aws_subnet.public-1.id}"
  route_table_id  = "${aws_route_table.outbound_route.id}"
}

resource "aws_instance" "www-1" {
  ami = "ami-13e45c77"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public-1.id}"
  security_groups = ["${aws_security_group.access_web_sg.id}"]
  key_name  = "cmills-key"
  
  tags {
    Name = "www-1"
  }
}
