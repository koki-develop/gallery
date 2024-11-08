module "s3_bucket_frontend" {
  source = "../common/s3_bucket"
  bucket = "${var.name}-frontend"
}

resource "aws_s3_bucket_policy" "frontend" {
  bucket = module.s3_bucket_frontend.this.id
  policy = data.aws_iam_policy_document.s3_bucket_frontend_policy.json
}

data "aws_iam_policy_document" "s3_bucket_frontend_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_bucket_frontend.this.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.frontend.arn]
    }
  }
}

module "frontend" {
  source = "../frontend"
}

resource "aws_s3_object" "frontend_index" {
  bucket       = module.s3_bucket_frontend.this.id
  key          = "index.html"
  content      = module.frontend.index_html
  content_type = "text/html"
}
