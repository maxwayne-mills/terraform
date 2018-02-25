# Volume will be attached automatically, no need to specify

data "scaleway_image" "platform" {
  architecture = "${var.image_arch}"
  name         = "${var.image_os}"
}

resource "scaleway_server" "test" {
  name  = "${var.server_name}"
  image = "${data.scaleway_image.platform.id}"
  type  = "${var.scaleway_type}"
}
