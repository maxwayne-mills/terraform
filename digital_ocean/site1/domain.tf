resource "digitalocean_domain" "domain_name" {
  name       = "${var.web_domain}"
  ip_address = "${digitalocean_droplet.www1.ipv4_address}"
}

resource "digitalocean_record" "domain_record" {
  domain = "${digitalocean_domain.domain_name.name}"
  type   = "A"
  name   = "master"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_droplet.www1.ipv4_address}"
}

resource "digitalocean_record" "domain_record2" {
  domain = "${digitalocean_domain.domain_name.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_droplet.www1.ipv4_address}"
}
