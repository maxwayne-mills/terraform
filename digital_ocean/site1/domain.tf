resource "digitalocean_domain" "millsresidence" {
  name       = "millsresidence.com"
  ip_address = "${digitalocean_droplet.www1.ipv4_address}"
}

resource "digitalocean_record" "millsresidence" {
  domain = "${digitalocean_domain.millsresidence.name}"
  type   = "A"
  name   = "www"
  value  = "${digitalocean_droplet.www1.ipv4_address}"
}
