resource "digitalocean_domain" "domain_name1" {
  name       = "${var.web_domain1}"
  ip_address = "${digitalocean_droplet.www1.ipv4_address}"
}

resource "digitalocean_record" "domain_record1" {
  domain = "${digitalocean_domain.domain_name1.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_droplet.www1.ipv4_address}"
}

# Second domain 
resource "digitalocean_domain" "domain_name2" {
  name       = "${var.web_domain2}"
  ip_address = "${digitalocean_droplet.www1.ipv4_address}"
}

resource "digitalocean_record" "domain_record2" {
  domain = "${digitalocean_domain.domain_name2.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_droplet.www1.ipv4_address}"
}

# Sixth domain 
resource "digitalocean_domain" "domain_name6" {
  name       = "${var.web_domain6}"
  ip_address = "${digitalocean_droplet.www1.ipv4_address}"
}

resource "digitalocean_record" "domain_record6" {
  domain = "${digitalocean_domain.domain_name6.name}"
  type   = "A"
  name   = "www"
  ttl    = "${var.ttl_life}"
  value  = "${digitalocean_droplet.www1.ipv4_address}"
}
