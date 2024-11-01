data "js_function" "main" {
  name  = "listImages"
  async = true
  body = [
    data.js_const.response.content,
    data.js_if.not_response_ok.content,
    data.js_return.response_json.content,
  ]
}

data "js_function_call" "fetch" {
  function = "fetch"
  args     = ["https://picsum.photos/v2/list"]
}

data "js_await" "fetch" {
  value = data.js_function_call.fetch.content
}

data "js_const" "response" {
  name  = "response"
  value = data.js_await.fetch.content
}

data "js_raw" "not_response_ok" {
  value = "!response.ok"
}

data "js_new" "error" {
  constructor = "Error"
  args        = ["Failed to fetch images"]
}

data "js_throw" "error" {
  value = data.js_new.error.content
}

data "js_if" "not_response_ok" {
  condition = data.js_raw.not_response_ok.content
  then      = [data.js_throw.error.content]
}

data "js_function_call" "response_json" {
  caller   = data.js_const.response.id
  function = "json"
}

data "js_await" "response_json" {
  value = data.js_function_call.response_json.content
}

data "js_return" "response_json" {
  value = data.js_await.response_json.content
}
