data "js_program" "main" {
  statements = [
    # variables
    data.js_const.app.statement,
    data.js_const.loader.statement,
    data.js_const.modal.statement,
    data.js_const.modal_image_template.statement,
    data.js_const.image_list_template.statement,
    data.js_const.image_list_item_template.statement,

    # functions
    module.function_fetch_images.this.statement,
    module.function_calc_thumb_size.this.statement,
    module.function_build_image_list.this.statement,
    module.function_build_image_list_item.this.statement,

    # main
    data.js_function.main.statement,
    data.js_function_call.main.statement,
  ]
}

data "js_function_call" "main" {
  function = data.js_function.main.id
}

data "js_const" "app" {
  name  = "app"
  value = data.js_function_call.app.expression
}

data "js_function_call" "app" {
  caller   = "document"
  function = "querySelector"
  args     = ["#app"]
}

data "js_const" "loader" {
  name  = "loader"
  value = data.js_function_call.loader.expression
}

data "js_function_call" "loader" {
  caller   = "document"
  function = "querySelector"
  args     = ["#loader"]
}

data "js_const" "modal" {
  name  = "modal"
  value = data.js_function_call.modal.expression
}

data "js_function_call" "modal" {
  caller   = "document"
  function = "querySelector"
  args     = ["#modal"]
}

data "js_const" "image_list_template" {
  name  = "imageListTemplate"
  value = data.js_function_call.image_list_template.expression
}

data "js_function_call" "image_list_template" {
  caller   = "document"
  function = "querySelector"
  args     = ["#image-list-template"]
}

data "js_const" "image_list_item_template" {
  name  = "imageListItemTemplate"
  value = data.js_function_call.image_list_item_template.expression
}

data "js_function_call" "image_list_item_template" {
  caller   = "document"
  function = "querySelector"
  args     = ["#image-list-item-template"]
}

data "js_const" "modal_image_template" {
  name  = "modalImageTemplate"
  value = data.js_function_call.modal_image_template.expression
}

data "js_function_call" "modal_image_template" {
  caller   = "document"
  function = "querySelector"
  args     = ["#modal-image-template"]
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
  const_modal_id                    = data.js_const.modal.id
  const_modal_image_template_id     = data.js_const.modal_image_template.id
  function_calc_thumb_size_id       = module.function_calc_thumb_size.this.id
}

data "js_function" "main" {
  name  = "main"
  async = true
  body = [
    data.js_function_call.modal_add_event_listener.statement,
    data.js_const.images.statement,
    data.js_function_call.loader_remove.statement,
    data.js_const.image_list.statement,
    data.js_function_call.app_append_child.statement,
  ]
}

data "js_const" "images" {
  name  = "images"
  value = data.js_await.fetch_images.expression
}

data "js_await" "fetch_images" {
  value = data.js_function_call.fetch_images.expression
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
  value = data.js_function_call.build_image_list.expression
}

data "js_function_call" "build_image_list" {
  function = module.function_build_image_list.this.id
  args     = [data.js_const.images.id]
}

data "js_function_call" "modal_add_event_listener" {
  caller   = data.js_const.modal.id
  function = "addEventListener"
  args     = ["click", data.js_function.modal_close.expression]
}

data "js_function" "modal_close" {
  params = [data.js_function_param.event.id]
  body   = [data.js_if.modal_click_is_modal.statement]
}

data "js_function_param" "event" {
  name = "event"
}

data "js_if" "modal_click_is_modal" {
  condition = data.js_operation.modal_click_is_modal.expression
  then      = [data.js_function_call.modal_close.statement]
}

data "js_operation" "modal_click_is_modal" {
  left     = data.js_index.event_target.expression
  operator = "==="
  right    = data.js_const.modal.id
}

data "js_index" "event_target" {
  ref   = data.js_function_param.event.id
  value = "target"
}

data "js_function_call" "modal_close" {
  caller   = data.js_const.modal.id
  function = "close"
}

data "js_function_call" "app_append_child" {
  caller   = data.js_const.app.id
  function = "appendChild"
  args     = [data.js_const.image_list.id]
}
