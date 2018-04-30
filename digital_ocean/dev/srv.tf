resource "digitalocean_droplet" "tst-srv" {
  image       = "${var.droplet_image}"
  name        = "${var.tst-srv}"
  region      = "${var.region}"
  size        = "${var.droplet_memory_size}"
  ssh_keys    = ["${var.ssh_fingerprint}"]
  user_data   = "${file("cloud_init/user_data.yml")}"
  monitoring  = "true"
  resize_disk = "false"

  # Create ansible configuration file
  #  provisioner "local-exec" {
  #command = "sleep 20 && echo \"[srv1]\n${digitalocean_droplet.tst-srv.ipv4_address} ansible_connection=ssh ansible_ssh_user=deployuser\" > inventory"
  #}
}

resource "digitalocean_floating_ip" "tst-srv" {
  droplet_id = "${digitalocean_droplet.tst-srv.id}"
  region     = "${var.region}"
}
