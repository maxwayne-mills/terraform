resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"
  tags {
    Name = "terraform-aws-vpc"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"		# attach aws_internet_gateway(instance _name = internet_gateway) to vpc (VLAN) created above
}				        # reference by id once created using terraform	


/*
  NAT Instance
*/

resource "aws_security_group" "nat" {
  name = "vpc_nat"
  description = "Allow traffice to pass from private subnet to the internet"
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
   }

   ingress {
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
   }
       
   egress {
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
    }

   egress {
     from_port = -1
     to_port = -1
     protocol = "icmp"
     cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.vpc.id}"

    tags {
      Name = "Nat_security_group`"
    }
}

resource "aws_instance" "nat" {
  ami = "${var.nat_ami}"
  availability_zone = "${var.aws_nat_region}"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.nat.id}"]
  subnet_id = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  source_dest_check = false

  tags {
    Name = "VPC Nat"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"		# attach route table to vpc created above using the id
  route {
    cidr_block = "0.0.0.0/0"		# create route to internet 
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"  #tag route table to aws_internet_gateway instance (router), thereby routing all outbound traffic
    }
  tags {
    Name = "public"
    }
}

resource "aws_default_route_table" "private" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"
  tags {
    Name = "private"
    }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.vpc.id}"		# attach to the vpc created above
  cidr_block = "${var.public_subnet_cidr}" # public subne within the vpc cidr block created above
  map_public_ip_on_launch = true	# map an ip from the public subnet to instances on launc
  availability_zone = "ca-central-1b"
  tags {
    Name = "public"
    }
}

resource "aws_subnet" "private1" {
  vpc_id = "${aws_vpc.vpc.id}"			# tag to vpc created above
  cidr_block = "${var.private_subnet_cidr}" 	# private subnet within the vpc created above	
  map_public_ip_on_launch = false	# don't give public ip to instances with the private zone
  availability_zone = "ca-central-1b"
  tags {
    Name = "private1"
   }
}

## associate subnets with routing tables

