resource "aws_lambda_function" "api_get_images" {
  function_name    = "${var.name}-api-get-images"
  role             = aws_iam_role.api_assume_role.arn
  runtime          = "nodejs20.x"
  source_code_hash = data.archive_file.api_get_images_js.output_base64sha256
  filename         = data.archive_file.api_get_images_js.output_path
  handler          = "api-get-images.handler"
  publish          = true
}

module "get_images_js" {
  source = "../backend/get_images"
}

data "archive_file" "api_get_images_js" {
  type                    = "zip"
  output_path             = "${path.module}/dist/api-get-images.zip"
  source_content_filename = "api-get-images.mjs"
  source_content          = module.get_images_js.content
}
