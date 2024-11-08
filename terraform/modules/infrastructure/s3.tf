module "s3_bucket_frontend" {
  source = "../common/s3_bucket"
  bucket = "${var.name}-frontend"
}
