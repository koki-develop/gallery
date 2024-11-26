data "js_function" "main" {
  name   = "buildModalImage"
  params = [data.js_function_param.src.id]
  body = [
    data.js_const.modal_image.statement,
    data.js_operation.set_modal_image_src.statement,
    data.js_function_call.modal_image_add_event_listener.statement,
    data.js_return.modal_image.statement
  ]
}

data "js_function_param" "src" {
  name = "src"
}

data "js_const" "modal_image" {
  name  = "modalImage"
  value = data.js_function_call.modal_image_template_content_clone_node.expression
}

data "js_index" "modal_image_template_content" {
  ref   = var.const_modal_image_template_id
  value = "content"
}

data "js_function_call" "modal_image_template_content_clone_node" {
  caller   = data.js_index.modal_image_template_content.id
  function = "cloneNode"
  args     = [true]
}

data "js_function_call" "modal_image_query_selector" {
  caller   = data.js_const.modal_image.id
  function = "querySelector"
  args     = ["img"]
}

data "js_index" "modal_image_src" {
  ref   = data.js_function_call.modal_image_query_selector.expression
  value = "src"
}

data "js_operation" "set_modal_image_src" {
  left     = data.js_index.modal_image_src.expression
  operator = "="
  right    = data.js_function_param.src.id
}

data "js_function_call" "modal_image_add_event_listener" {
  caller   = data.js_const.modal_image.id
  function = "addEventListener"
  args     = ["load", data.js_function.on_load.expression]
}

data "js_function" "on_load" {
  body = [
    data.js_function_call.modal_image_class_list_remove.statement,
    data.js_function_call.modal_image_loader_class_list_add.statement
  ]
}

data "js_index" "modal_image_class_list" {
  ref   = data.js_function_call.modal_image_query_selector.expression
  value = "classList"
}

data "js_function_call" "modal_image_class_list_remove" {
  caller   = data.js_index.modal_image_class_list.id
  function = "remove"
  args     = ["hidden"]
}

data "js_function_call" "modal_image_loader" {
  caller   = data.js_const.modal_image.id
  function = "querySelector"
  args     = ["#modal-image-loader"]
}

data "js_index" "modal_image_loader_class_list" {
  ref   = data.js_function_call.modal_image_loader.expression
  value = "classList"
}

data "js_function_call" "modal_image_loader_class_list_add" {
  caller   = data.js_index.modal_image_loader_class_list.id
  function = "add"
  args     = ["hidden"]
}

data "js_return" "modal_image" {
  value = data.js_const.modal_image.id
}
