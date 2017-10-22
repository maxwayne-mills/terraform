resource "aws_instance" "www-1" {
 ami		= "ami-13e45c77"
 instance_type	= "t2.micro"

 tags {
  name		= "w1-clarencemills"
 }   
}
