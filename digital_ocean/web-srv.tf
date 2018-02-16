resource "digitalocean_droplet" "www1" {
    image = "${var.droplet_image}"
    name = "${var.websrv_name}"
    region = "${var.region}"
    size = "${var.droplet_memory_size}"
    ssh_keys = ["${var.ssh_fingerprint}"]
}