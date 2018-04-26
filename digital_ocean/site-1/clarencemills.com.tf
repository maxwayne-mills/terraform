# Fifth domain 
resource "digitalocean_domain" "clarencemills" {
  name       = "clarencemills.com"
  ip_address = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "clarencemills-a" {
  domain = "${digitalocean_domain.clarencemills.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "clarencemills-mx" {
  domain   = "${digitalocean_domain.clarencemills.name}"
  type     = "MX"
  ttl      = "${var.ttl_life}"
  priority = "10"
  value    = "mailstore1.secureserver.net."
}

resource "digitalocean_record" "clarencemills_mx2" {
  domain   = "${digitalocean_domain.clarencemills.name}"
  type     = "MX"
  ttl      = "${var.ttl_life}"
  priority = "1"
  value    = "smtp.secureserver.net."
}
