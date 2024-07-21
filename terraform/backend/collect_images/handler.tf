resource "js_function_call" "hello" {
  caller   = "console"
  function = "log"
  args     = ["hello, world"]
}

resource "js_function" "handler" {
  async = true
  body  = [js_function_call.hello.content]
}

data "js_raw" "exports_handler" {
  value = "exports.handler"
}

resource "js_operation" "exports_handler" {
  left     = data.js_raw.exports_handler.content
  operator = "="
  right    = js_function.handler.content
}

resource "js_program" "main" {
  contents = [js_operation.exports_handler.content]
}
