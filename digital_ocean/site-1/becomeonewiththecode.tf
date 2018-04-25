resource "digitalocean_domain" "becomeonewiththecode" {
  name       = "becomeonewiththecode.com"
  ip_address = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "becomeonewiththecode-a" {
  domain = "${digitalocean_domain.becomeonewiththecode.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_floating_ip.srv1.id}"
}