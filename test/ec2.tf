resource "aws_instance" "test_ec2" {
  ami                    = "${var.ami_name}"
  instance_type          = "${var.instance_name}"
  key_name               = "cmills-key"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags {
    Name = "Test instance"
  }
}
