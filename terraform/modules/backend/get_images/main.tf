data "js_program" "main" {
  statements = [
    data.js_const.cache.statement,
    data.js_export.main.statement,
  ]
}

data "js_const" "cache" {
  name  = "cache"
  value = {}
}

data "js_export" "main" {
  value = data.js_function.handler.expression
}

data "js_function" "handler" {
  name  = "handler"
  async = true
  body = [
    data.js_const.page.statement,
    data.js_if.cache_hit.statement,
    data.js_const.response.statement,
    data.js_const.images.statement,
    data.js_operation.cache_images.statement,
    data.js_return.images.statement,
  ]
}

data "js_const" "page" {
  name  = "page"
  value = data.js_operation.floor_random_plus_1.expression
}

data "js_operation" "floor_random_plus_1" {
  left     = data.js_function_call.floor_random.expression
  operator = "+"
  right    = 1
}

data "js_function_call" "floor_random" {
  caller   = "Math"
  function = "floor"
  args     = [data.js_operation.random_times_10.expression]
}

data "js_operation" "random_times_10" {
  left     = data.js_function_call.random.expression
  operator = "*"
  right    = 10
}

data "js_function_call" "random" {
  caller   = "Math"
  function = "random"
}

data "js_if" "cache_hit" {
  condition = data.js_index.cache_page.expression
  then      = [data.js_return.cache_hit.statement]
}

data "js_index" "cache_page" {
  ref   = data.js_const.cache.id
  value = data.js_const.page.id
}

data "js_return" "cache_hit" {
  value = data.js_index.cache_page.expression
}

data "js_const" "response" {
  name  = "response"
  value = data.js_await.fetch.expression
}

data "js_await" "fetch" {
  value = data.js_function_call.fetch.expression
}

data "js_function_call" "fetch" {
  function = "fetch"
  args     = [data.js_raw.url.content]
}

data "js_raw" "url" {
  value = "`https://picsum.photos/v2/list?page=$${page}&limit=30`"
}

data "js_const" "images" {
  name  = "images"
  value = data.js_await.response_json.expression
}

data "js_await" "response_json" {
  value = data.js_function_call.response_json.expression
}

data "js_function_call" "response_json" {
  caller   = data.js_const.response.id
  function = "json"
}

data "js_operation" "cache_images" {
  left     = data.js_index.cache_page.id
  operator = "="
  right    = data.js_const.images.id
}

data "js_return" "images" {
  value = data.js_const.images.id
}
