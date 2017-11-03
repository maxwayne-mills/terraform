resource "aws_key_pair" "cmills" {
  key_name   = "cmills-key"
  public_key = "${file(var.public_key_path)}"
}
