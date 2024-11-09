resource "aws_apigatewayv2_api" "main" {
  name          = "${var.name}-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_methods = ["GET"]
    allow_origins = ["https://${var.domain}"]
    max_age       = 3600
  }
}

resource "aws_apigatewayv2_stage" "v1" {
  name        = "v1"
  api_id      = aws_apigatewayv2_api.main.id
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "get_images" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "GET /images"
  target    = "integrations/${aws_apigatewayv2_integration.get_images.id}"
}

resource "aws_apigatewayv2_integration" "get_images" {
  api_id                 = aws_apigatewayv2_api.main.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.api_get_images.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_lambda_permission" "api_get_images" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_get_images.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}
