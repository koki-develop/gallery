data "html_script" "main" {
  children = [data.js_program.main.content]
}

data "js_program" "main" {
  contents = [
    module.function_fetch_images.this.content,
    module.function_calc_thumb_size.this.content,
    data.js_function.main.content,
    data.js_function_call.main.content,
  ]
}

module "function_fetch_images" {
  source = "./functions/fetch_images"
}

module "function_calc_thumb_size" {
  source = "./functions/calc_thumb_size"
}

data "js_function" "main" {
  name  = "main"
  async = true
  body = [
    data.js_const.images.content,
    data.js_function_call.log_images.content,
  ]
}

data "js_const" "images" {
  name  = "images"
  value = data.js_await.fetch_images.content
}

data "js_await" "fetch_images" {
  value = data.js_function_call.fetch_images.content
}

data "js_function_call" "fetch_images" {
  function = module.function_fetch_images.this.id
}

# TODO: remove
data "js_function_call" "log_images" {
  caller   = "console"
  function = "log"
  args     = [data.js_const.images.id]
}

data "js_function_call" "main" {
  function = data.js_function.main.id
}
