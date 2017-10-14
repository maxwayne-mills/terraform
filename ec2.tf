# Single element
resource "aws_instance" "base" {
  ami		= "ami-1cda6278"
  instance_type	= "${var.ami-type}"
}

resource "aws_eip" "base" {
  instance = "${aws_instance.base.id}"
}
