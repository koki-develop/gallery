data "aws_cloudfront_origin_request_policy" "cors_s3_origin" {
  name = "Managed-CORS-S3Origin"
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

resource "aws_cloudfront_distribution" "frontend" {
  enabled             = true
  default_root_object = "index.html"
  aliases             = [var.domain]

  origin {
    origin_id                = module.s3_bucket_frontend.this.id
    domain_name              = module.s3_bucket_frontend.this.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend.id
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.frontend.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    target_origin_id         = module.s3_bucket_frontend.this.id
    viewer_protocol_policy   = "redirect-to-https"
    cached_methods           = ["GET", "HEAD"]
    allowed_methods          = ["GET", "HEAD"]
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.cors_s3_origin.id
    cache_policy_id          = data.aws_cloudfront_cache_policy.caching_disabled.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "frontend" {
  name                              = "${var.name}-frontend"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
