resource "aws_key_pair" "cmills" {
  key_name  = "cmills-key"
  public_key  = "${var.my_key}"
}
