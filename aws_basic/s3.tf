resource "aws_s3_bucket" "mills-storage" {
  bucket = "mills-storage"
  acl    = "private"

  tags {
    name = "Mills Storage"
  }
}
