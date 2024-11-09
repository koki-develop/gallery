data "js_program" "main" {
  contents = [
    data.js_const.image_list_template.content,
    module.function_fetch_images.this.content,
    module.function_calc_thumb_size.this.content,
    module.function_build_image_list.this.content,
    data.js_function.main.content,
    data.js_function_call.main.content,
  ]
}

data "js_const" "image_list_template" {
  name  = "imageListTemplate"
  value = data.js_function_call.image_list_template.content
}

data "js_function_call" "image_list_template" {
  caller   = "document"
  function = "querySelector"
  args     = ["#image-list-template"]
}

module "function_fetch_images" {
  source = "./functions/fetch_images"
}

module "function_calc_thumb_size" {
  source = "./functions/calc_thumb_size"
}

module "function_build_image_list" {
  source                            = "./functions/build_image_list"
  const_image_list_template_id      = data.js_const.image_list_template.id
  function_build_image_list_item_id = "buildImageListItem" # TODO
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
