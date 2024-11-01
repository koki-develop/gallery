resource "aws_lambda_function" "main" {
  function_name = "${var.name}-collect-images"
  role          = aws_iam_role.assume_role.arn
  publish       = true

  runtime          = "nodejs20.x"
  source_code_hash = data.archive_file.index_js.output_base64sha256
  filename         = data.archive_file.index_js.output_path
  handler          = "index.handler"
}

resource "aws_iam_role" "assume_role" {
  name               = "${var.name}-collect-images"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "archive_file" "index_js" {
  type                    = "zip"
  output_path             = "${path.module}/index.js.zip"
  source_content_filename = "index.js"
  source_content          = data.js_program.main.content
}
