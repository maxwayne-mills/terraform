resource "digitalocean_domain" "neatandfine" {
  name       = "neatandfine.com"
  ip_address = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "neatandfine-a" {
  domain = "${digitalocean_domain.neatandfine.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_floating_ip.srv1.id}"
}