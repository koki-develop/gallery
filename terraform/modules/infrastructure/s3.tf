module "s3_bucket_frontend" {
  source = "./common/s3_bucket"
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

module "index_html" {
  source = "../frontend/index_html"
}

resource "aws_s3_object" "frontend_index" {
  bucket       = module.s3_bucket_frontend.this.id
  key          = "index.html"
  content      = module.index_html.content
  content_type = "text/html"
}

module "script_js" {
  source       = "../frontend/script_js"
  api_base_url = aws_apigatewayv2_stage.v1.invoke_url
}

resource "aws_s3_object" "frontend_script" {
  bucket  = module.s3_bucket_frontend.this.id
  key     = "script.js"
  content = module.script_js.content
}
