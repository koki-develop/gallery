data "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.main.id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.frontend.domain_name
    zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "frontend_certificate_validation" {
  for_each = {
    for options in aws_acm_certificate.frontend.domain_validation_options : options.domain_name => {
      name  = options.resource_record_name
      type  = options.resource_record_type
      value = options.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 3600
}
