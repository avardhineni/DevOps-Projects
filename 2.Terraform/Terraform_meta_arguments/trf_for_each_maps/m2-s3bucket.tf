resource "aws_s3_bucket" "mys3bucket" {
  for_each = {
    dev  = "my-dev-bucket"
    qa   = "my-qa-bucket"
    stag = "my-stag-bucket"
    prod = "my-prod-bucket"
  }

  bucket = "${each.key}-${each.value}"
  acl    = "private"

  tags = {
    Environment = each.key
    bucketname  = "${each.key}-${each.value}"
    eachvalue   = each.value
  }
}