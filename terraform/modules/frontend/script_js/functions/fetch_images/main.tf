data "js_function" "main" {
  name  = "fetchImages"
  async = true
  body = [
    data.js_const.images.statement,
    data.js_return.images.statement,
  ]
}

data "js_const" "images" {
  name  = "images"
  value = data.js_await.fetch.expression
}

data "js_await" "fetch" {
  value = data.js_function_call.fetch_then.expression
}

data "js_function_call" "fetch" {
  function = "fetch"
  args     = [var.api_endpoint]
}

data "js_function_call" "fetch_then" {
  caller   = data.js_function_call.fetch.expression
  function = "then"
  args     = [data.js_function.fetch_callback.expression]
}

data "js_function" "fetch_callback" {
  params = [data.js_function_param.fetch_callback_response.id]
  body   = [data.js_return.response_json.statement]
}

data "js_function_param" "fetch_callback_response" {
  name = "response"
}

data "js_function_call" "response_json" {
  caller   = data.js_function_param.fetch_callback_response.id
  function = "json"
}

data "js_return" "response_json" {
  value = data.js_function_call.response_json.expression
}

data "js_return" "images" {
  value = data.js_const.images.id
}
