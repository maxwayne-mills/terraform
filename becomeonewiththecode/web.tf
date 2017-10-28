resource "aws_instance" "www-1" {
  ami = "ami-13e45c77"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public-1.id}"
  security_groups = ["${aws_security_group.access_web_sg.id}"]
  key_name  = "cmills-key"
  tags {
    Name = "www-1"
  }

  provisioner "local-exec"{
     command    = "echo localhost     ansible_host=${self.public_ip} >> hosts"
  }

  provisioner "file" {
    source      = "scripts/install_apps.sh"
    destination = "/tmp/install_apps.sh"

    connection {
      type      = "ssh"
      user      = "ubuntu"
      #private_key = "${file("/home/cmills/.ssh/id_rsa")}"
      private_key = "${file("${var.key_path}")}"
      agent     = false
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_apps.sh",
       "sudo /tmp/install_apps.sh",
        ]
    connection {
      type      = "ssh"
      user      = "ubuntu"
      #private_key = "${file("/home/cmills/.ssh/id_rsa")}"
      private_key = "${file("${var.key_path}")}"
      agent     = false
    }
  }

}

