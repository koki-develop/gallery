module "fetch_image" {
  source = "./functions/fetch_image"
}

resource "js_function_call" "hello" {
  caller   = "console"
  function = "log"
  args     = ["hello, world"]
}

resource "js_function" "handler" {
  name  = "handler"
  async = true
  body = [
    module.fetch_image.content,
    js_function_call.hello.content,
  ]
}

resource "js_export" "handler" {
  value = js_function.handler.content
}

resource "js_program" "main" {
  contents = [js_export.handler.content]
}
