# Create A record for domain assigned to floating IP
resource "digitalocean_domain" "fixyourip" {
  name       = "fixyourip.com"
  ip_address = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "fixyourip-a" {
  domain = "${digitalocean_domain.fixyourip.name}"
  type   = "A"
  name   = "www"
  ttl    = "30"
  value  = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "fixyourip-mx" {
  domain   = "${digitalocean_domain.fixyourip.name}"
  type     = "MX"
  ttl      = "30"
  priority = "5"
  value    = "ALT1.ASPMX.L.GOOGLE.com."
}

resource "digitalocean_record" "fixyourip-mx2" {
  domain   = "${digitalocean_domain.fixyourip.name}"
  type     = "MX"
  ttl      = "30"
  priority = "5"
  value    = "ALT2.ASPMX.L.GOOGLE.com."
}

resource "digitalocean_record" "fixyourip-mx3" {
  domain   = "${digitalocean_domain.fixyourip.name}"
  type     = "MX"
  ttl      = "30"
  priority = "1"
  value    = "ASPMX.L.GOOGLE.com."
}

resource "digitalocean_record" "fixyourip-mx4" {
  domain   = "${digitalocean_domain.fixyourip.name}"
  type     = "MX"
  ttl      = "30"
  priority = "10"
  value    = "ASPMX2.GOOGLEMAIL.com."
}

resource "digitalocean_record" "fixyourip-mx5" {
  domain   = "${digitalocean_domain.fixyourip.name}"
  type     = "MX"
  ttl      = "30"
  priority = "10"
  value    = "ASPMX3.GOOGLEMAIL.com."
}

resource "digitalocean_record" "fixyourip-mx6" {
  domain   = "${digitalocean_domain.fixyourip.name}"
  type     = "MX"
  ttl      = "30"
  priority = "10"
  value    = "ASPMX4.GOOGLEMAIL.com."
}

resource "digitalocean_record" "fixyourip-mx7" {
  domain   = "${digitalocean_domain.fixyourip.name}"
  type     = "MX"
  ttl      = "30"
  priority = "10"
  value    = "ASPMX5.GOOGLEMAIL.com."
}

resource "digitalocean_record" "fixyourip-cname" {
  domain = "${digitalocean_domain.fixyourip.name}"
  type   = "CNAME"
  name   = "mail"
  ttl    = "300"
  value  = "ghs.googlehosted.com."
}

resource "digitalocean_record" "fixyourip-cname1" {
  domain = "${digitalocean_domain.fixyourip.name}"
  type   = "CNAME"
  name   = "drive"
  ttl    = "300"
  value  = "ghs.googlehosted.com."
}

resource "digitalocean_record" "fixyourip-cname2" {
  domain = "${digitalocean_domain.fixyourip.name}"
  type   = "CNAME"
  name   = "calendar"
  ttl    = "300"
  value  = "ghs.googlehosted.com."
}

resource "digitalocean_record" "fixyourip-cname3" {
  domain = "${digitalocean_domain.fixyourip.name}"
  type   = "CNAME"
  name   = "docs"
  ttl    = "300"
  value  = "ghs.googlehosted.com."
}
