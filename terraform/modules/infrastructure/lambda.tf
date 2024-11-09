resource "aws_lambda_function" "api" {
  function_name    = "${var.name}-api"
  role             = aws_iam_role.api_assume_role.arn
  runtime          = "nodejs20.x"
  source_code_hash = data.archive_file.api_js.output_base64sha256
  filename         = data.archive_file.api_js.output_path
  handler          = "api.handler"
  publish          = true
}

data "archive_file" "api_js" {
  type                    = "zip"
  output_path             = "${path.module}/dist/api.zip"
  source_content_filename = "api.mjs"
  source_content          = var.api_js_content
}
