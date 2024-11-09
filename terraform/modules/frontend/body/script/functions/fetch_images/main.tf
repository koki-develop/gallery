data "js_function" "main" {
  name  = "fetchImages"
  async = true
  body = [
    data.js_const.images.content,
    data.js_return.images.content,
  ]
}

data "js_const" "images" {
  name  = "images"
  value = data.js_await.fetch.content
}

data "js_await" "fetch" {
  value = data.js_function_call.fetch_then.content
}

data "js_function_call" "fetch" {
  function = "fetch"
  args     = ["https://picsum.photos/v2/list?limit=50"]
}

data "js_function_call" "fetch_then" {
  caller   = data.js_function_call.fetch.content
  function = "then"
  args     = [data.js_function.fetch_callback.content]
}

data "js_function" "fetch_callback" {
  params = [data.js_function_param.fetch_callback_response.id]
  body   = [data.js_return.response_json.content]
}

data "js_function_param" "fetch_callback_response" {
  name = "response"
}

data "js_function_call" "response_json" {
  caller   = data.js_function_param.fetch_callback_response.id
  function = "json"
}

data "js_return" "response_json" {
  value = data.js_function_call.response_json.content
}

data "js_return" "images" {
  value = data.js_const.images.id
}
