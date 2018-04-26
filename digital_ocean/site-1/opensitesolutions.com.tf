# Create A record for domain assigned to floating IP
resource "digitalocean_domain" "opensitesolutions" {
  name       = "opensitesolutions.com"
  ip_address = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "opensitesolutions-a" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type   = "A"
  name   = "www"
  ttl    = "30"
  value  = "${digitalocean_floating_ip.srv1.id}"
}

resource "digitalocean_record" "opensitesolutions-mx" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "MX"
  ttl  = "30"
  priority = "5"
  value = "ALT1.ASPMX.L.GOOGLE.com."
}

resource "digitalocean_record" "opensitesolutions-mx2" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "MX"
  ttl  = "30"
  priority = "5"
  value = "ALT2.ASPMX.L.GOOGLE.com."
}

resource "digitalocean_record" "opensitesolutions-mx3" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "MX"
  ttl  = "30"
  priority = "10"
  value = "ALT3.ASPMX.L.GOOGLE.com."
}

resource "digitalocean_record" "opensitesolutions-mx4" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "MX"
  ttl  = "30"
  priority = "10"
  value = "ALT4.ASPMX.L.GOOGLEMAIL.com."
}

resource "digitalocean_record" "opensitesolutions-mx5" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "MX"
  ttl  = "30"
  priority = "1"
  value = "ASPMX.GOOGLEMAIL.com."
}

resource "digitalocean_record" "opensitesolutions-cname" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "CNAME"
  name = "mail"
  ttl  = "300"
  value = "ghs.googlehosted.com."
}

resource "digitalocean_record" "opensitesolutions-cname1" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "CNAME"
  name = "drive"
  ttl  = "300"
  value = "ghs.googlehosted.com."
}

resource "digitalocean_record" "opensitesolutions-cname2" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "CNAME"
  name = "calendar"
  ttl  = "300"
  value = "ghs.googlehosted.com."
}

resource "digitalocean_record" "opensitesolutions-cname3" {
  domain = "${digitalocean_domain.opensitesolutions.name}"
  type = "CNAME"
  name = "docs"
  ttl  = "300"
  value = "ghs.googlehosted.com."
}

resource "digitialocean_record" "opensitesolutions-txt" {
   domain = "${digitalocean_domain.opensitesolutions.name}"
   type = "TXT"
   ttl = "300"
   value = "v=spf1 a include:_spf.google.com ~all"
}
