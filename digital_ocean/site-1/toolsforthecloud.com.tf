# Fifth domain 
resource "digitalocean_domain" "toolsforthecloud" {
  name       = "toolsforthecloud.com"
  ip_address = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "toolsforthecloud-a" {
  domain = "${digitalocean_domain.toolsforthecloud.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "toolsforthecloud-mx" {
  domain   = "${digitalocean_domain.toolsforthecloud.name}"
  type     = "MX"
  ttl      = "${var.ttl_life}"
  priority = "10"
  value    = "mailstore1.secureserver.net."
}

resource "digitalocean_record" "toolsforthecloud_mx2" {
  domain   = "${digitalocean_domain.toolsforthecloud.name}"
  type     = "MX"
  ttl      = "${var.ttl_life}"
  priority = "1"
  value    = "smtp.secureserver.net."
}
