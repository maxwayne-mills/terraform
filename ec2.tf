# Single element
resource "aws_instance" "base" {
  ami		= "ami-55da6231"
  instance_type	= "t2.micro"
}
