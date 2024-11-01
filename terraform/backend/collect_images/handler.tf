module "fetch_image" {
  source = "./functions/fetch_image"
}

data "js_function_call" "hello" {
  caller   = "console"
  function = "log"
  args     = ["hello, world"]
}

data "js_function" "handler" {
  name  = "handler"
  async = true
  body = [
    module.fetch_image.this.content,
    data.js_function_call.hello.content,
  ]
}

data "js_export" "handler" {
  value = data.js_function.handler.content
}

data "js_program" "main" {
  contents = [data.js_export.handler.content]
}
