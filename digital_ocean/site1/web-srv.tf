resource "digitalocean_droplet" "www1" {
  image    = "${var.droplet_image}"
  name     = "${var.websrv_name}"
  region   = "${var.region}"
  size     = "${var.droplet_memory_size}"
  ssh_keys = ["${var.ssh_fingerprint}"]

  provisioner "local-exec" {
    command = "sleep 20 && echo \"[webserver1]\n${digitalocean_droplet.www1.ipv4_address} ansible_connection=ssh ansible_ssh_user=root\" > inventory && ansible-playbook -i inventory ansible/roles/websrv/websrv.yml"
  }
}

resource "digitalocean_floating_ip" "www1" {
  droplet_id = "${digitalocean_droplet.www1.id}"
  region     = "${var.region}"
}
