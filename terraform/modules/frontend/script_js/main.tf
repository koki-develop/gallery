data "js_program" "main" {
  contents = [
    # variables
    data.js_const.app.content,
    data.js_const.loader.content,
    data.js_const.image_list_template.content,
    data.js_const.image_list_item_template.content,

    # functions
    module.function_fetch_images.this.content,
    module.function_calc_thumb_size.this.content,
    module.function_build_image_list.this.content,
    module.function_build_image_list_item.this.content,

    # main
    data.js_function.main.content,
    data.js_function_call.main.content,
  ]
}

data "js_function_call" "main" {
  function = data.js_function.main.id
}

data "js_const" "app" {
  name  = "app"
  value = data.js_function_call.app.content
}

data "js_function_call" "app" {
  caller   = "document"
  function = "querySelector"
  args     = ["#app"]
}

data "js_const" "loader" {
  name  = "loader"
  value = data.js_function_call.loader.content
}

data "js_function_call" "loader" {
  caller   = "document"
  function = "querySelector"
  args     = ["#loader"]
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

data "js_const" "image_list_item_template" {
  name  = "imageListItemTemplate"
  value = data.js_function_call.image_list_item_template.content
}

data "js_function_call" "image_list_item_template" {
  caller   = "document"
  function = "querySelector"
  args     = ["#image-list-item-template"]
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

module "function_build_image_list_item" {
  source                            = "./functions/build_image_list_item"
  const_image_list_item_template_id = data.js_const.image_list_item_template.id
  function_calc_thumb_size_id       = module.function_calc_thumb_size.this.id
}

data "js_function" "main" {
  name  = "main"
  async = true
  body = [
    data.js_const.images.content,
    data.js_function_call.loader_remove.content,
    data.js_const.image_list.content,
    data.js_function_call.app_append_child.content,
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

data "js_function_call" "loader_remove" {
  caller   = data.js_const.loader.id
  function = "remove"
}

data "js_const" "image_list" {
  name  = "imageList"
  value = data.js_function_call.build_image_list.content
}

data "js_function_call" "build_image_list" {
  function = module.function_build_image_list.this.id
  args     = [data.js_const.images.id]
}

data "js_function_call" "app_append_child" {
  caller   = data.js_const.app.id
  function = "appendChild"
  args     = [data.js_const.image_list.id]
}
