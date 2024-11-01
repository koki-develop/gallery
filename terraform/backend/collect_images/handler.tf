#
# import * as s3 from "@aws-sdk/client-s3";
#

data "js_import" "s3" {
  from = "@aws-sdk/client-s3"
  as   = "s3"
}

#
# const s3Client = new S3Client();
#

data "js_new" "s3_client" {
  constructor = "s3.S3Client"
}

data "js_const" "s3_client" {
  name  = "s3Client"
  value = data.js_new.s3_client.content
}

#
# define functions
#

module "fetch_image" {
  source = "./functions/fetch_image"
}

module "save_image" {
  source       = "./functions/save_image"
  name         = var.name
  s3_client_id = data.js_const.s3_client.id
}

#
# handler
#

data "js_function_call" "hello" {
  caller   = "console"
  function = "log"
  args     = ["hello, world"]
}

data "js_function" "handler" {
  name  = "handler"
  async = true
  body = [
    data.js_function_call.hello.content,
  ]
}

data "js_export" "handler" {
  value = data.js_function.handler.content
}

data "js_program" "main" {
  contents = [
    data.js_import.s3.content,
    data.js_const.s3_client.content,
    module.fetch_image.this.content,
    module.save_image.this.content,
    data.js_export.handler.content,
  ]
}
