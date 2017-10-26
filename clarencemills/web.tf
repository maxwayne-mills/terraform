resource "aws_instance" "www-1" {
  ami		= "ami-13e45c77"
  instance_type	= "t2.micro"

  tags {
   name		= "www-1"
  }   

  provisioner "local-exec" {
    command 	= "echo ${aws_instance.www-1.private_ip} >> private_ips.txt",
  }

  provisioner "local-exec" {
    command	= "echo ${aws_instance.www-1.public_ip} >> public_ips.txt"
  }

  provisioner "local-exec" {
    command 	= "sleep 120; ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook add_users.yml -vvvv" 
  }
}

resource "aws_security_group" "web-sg" {
  name		= "web-instance-security-group"

  ingress {
    from_port	= 8080
    to_port	= 8080
    protocol	= "tcp"
    cidr_blocks	= ["0.0.0.0/0"]
  }

}
